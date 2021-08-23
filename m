Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BA3F4C82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhHWOhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhHWOhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:37:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6BC061575;
        Mon, 23 Aug 2021 07:36:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D7F6F1F42234
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 04/21] fsnotify: Reserve mark flag bits for backends
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-5-krisman@collabora.com>
        <CAOQ4uxh0WNxsuwtfv_iDCaZbmJEDB700D5_v==ffm2-WAg_V7w@mail.gmail.com>
        <20210816131536.GB30215@quack2.suse.cz>
Date:   Mon, 23 Aug 2021 10:36:28 -0400
In-Reply-To: <20210816131536.GB30215@quack2.suse.cz> (Jan Kara's message of
        "Mon, 16 Aug 2021 15:15:36 +0200")
Message-ID: <87k0kc2poz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Fri 13-08-21 10:28:27, Amir Goldstein wrote:
>> On Fri, Aug 13, 2021 at 12:40 AM Gabriel Krisman Bertazi
>> <krisman@collabora.com> wrote:
>> >
>> > Split out the final bits of struct fsnotify_mark->flags for use by a
>> > backend.
>> >
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> >
>> > Changes since v1:
>> >   - turn consts into defines (jan)
>> > ---
>> >  include/linux/fsnotify_backend.h | 18 +++++++++++++++---
>> >  1 file changed, 15 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
>> > index 1ce66748a2d2..ae1bd9f06808 100644
>> > --- a/include/linux/fsnotify_backend.h
>> > +++ b/include/linux/fsnotify_backend.h
>> > @@ -363,6 +363,20 @@ struct fsnotify_mark_connector {
>> >         struct hlist_head list;
>> >  };
>> >
>> > +enum fsnotify_mark_bits {
>> > +       FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY,
>> > +       FSN_MARK_FL_BIT_ALIVE,
>> > +       FSN_MARK_FL_BIT_ATTACHED,
>> > +       FSN_MARK_PRIVATE_FLAGS,
>> > +};
>> > +
>> > +#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY \
>> > +       (1 << FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY)
>> > +#define FSNOTIFY_MARK_FLAG_ALIVE \
>> > +       (1 << FSN_MARK_FL_BIT_ALIVE)
>> > +#define FSNOTIFY_MARK_FLAG_ATTACHED \
>> > +       (1 << FSN_MARK_FL_BIT_ATTACHED)
>> > +
>> >  /*
>> >   * A mark is simply an object attached to an in core inode which allows an
>> >   * fsnotify listener to indicate they are either no longer interested in events
>> > @@ -398,9 +412,7 @@ struct fsnotify_mark {
>> >         struct fsnotify_mark_connector *connector;
>> >         /* Events types to ignore [mark->lock, group->mark_mutex] */
>> >         __u32 ignored_mask;
>> > -#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY 0x01
>> > -#define FSNOTIFY_MARK_FLAG_ALIVE               0x02
>> > -#define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
>> > +       /* Upper bits [31:PRIVATE_FLAGS] are reserved for backend usage */
>> 
>> I don't understand what [31:PRIVATE_FLAGS] means
>
> I think it should be [FSN_MARK_PRIVATE_FLAGS:31] (identifying a range of
> bits). I'd maybe write just "Bits starting from FSN_MARK_PRIVATE_FLAGS are
> reserved for backend usage". With this fixed feel free to add:

Thank you, I will address the comment and add your reviewed-by tags.

-- 
Gabriel Krisman Bertazi
