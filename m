Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F239234E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhEZXiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 19:38:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40050 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEZXiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 19:38:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6C0EE1F434FC
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 10/11] samples: Add fs error monitoring example
Organization: Collabora
References: <20210521024134.1032503-1-krisman@collabora.com>
        <20210521024134.1032503-11-krisman@collabora.com>
        <CAOQ4uxjk9K-yOyn4EAPjP_WK5UaCbcOGX4joH3futSCVTXZ76g@mail.gmail.com>
Date:   Wed, 26 May 2021 19:37:17 -0400
In-Reply-To: <CAOQ4uxjk9K-yOyn4EAPjP_WK5UaCbcOGX4joH3futSCVTXZ76g@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 21 May 2021 12:48:18 +0300")
Message-ID: <87tumpjccy.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> +                       printf("unexpected FAN MARK: %llx\n", metadata->mask);
>> +                       continue;
>> +               } else if (metadata->fd != FAN_NOFD) {
>> +                       printf("Unexpected fd (!= FAN_NOFD)\n");
>> +                       continue;
>> +               }
>> +
>> +               printf("FAN_ERROR found len=%d\n", metadata->event_len);
>> +
>> +               error = (struct fanotify_event_info_error *) (metadata+1);
>> +               if (error->hdr.info_type == FAN_EVENT_INFO_TYPE_ERROR) {
>
> You meant != FAN_EVENT_INFO_TYPE_ERROR ?

Ugh. the FAN_EVENT_INFO_TYPE_ERROR definition on this file was not updated,
preventing me from catching this. nice catch.
>
>> +                       printf("unknown record: %d\n", error->hdr.info_type);
>> +                       continue;
>> +               }
>> +
>> +               printf("  Generic Error Record: len=%d\n", error->hdr.len);
>> +               printf("      fsid: %llx\n", error->fsid);
>> +               printf("      error: %d\n", error->error);
>> +               printf("      inode: %lu\n", error->inode);
>> +               printf("      error_count: %d\n", error->error_count);
>> +       }
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       int fd;
>> +       char buffer[BUFSIZ];
>
> BUFSIZ not defined?

that's from stdio.h.


-- 
Gabriel Krisman Bertazi
