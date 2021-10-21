Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C939D435ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhJUKQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 06:16:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUKP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:15:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC63421989;
        Thu, 21 Oct 2021 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634811222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqKaSrVU3TFEpX9K803TdDDSaLm9aRwfDWOI2dQb5l0=;
        b=LfqQc63IqePPTrGfvArXOgm51JCIHXPNkLSYgA6w521jb1CBbgD7OXJjmlFT8LbQzjnOqY
        qUg5pOtkLWmn5qQs7R0Ynuor2Sssh3PM7fw9e6NlCyXN1d4UPMBpoedxHbM2kZELMzWEzR
        OXxMhJQ+uixx0PQlKv+K9HN8Rd1+jHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634811222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqKaSrVU3TFEpX9K803TdDDSaLm9aRwfDWOI2dQb5l0=;
        b=H2XjTRNORgvbgaSkMi0HBg+H46kOYPNoxpk6IhC0HhIyKu0ZKqJAKgcgpRdOVeMkA3s0xb
        SV2t7o+I+B++F1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F7C3140DA;
        Thu, 21 Oct 2021 10:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jhdbBFM9cWHWRQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 21 Oct 2021 10:13:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Uladzislau Rezki" <urezki@gmail.com>
Cc:     "Michal Hocko" <mhocko@suse.com>, "Michal Hocko" <mhocko@suse.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211020192430.GA1861@pc638.lan>
References: <20211018114712.9802-3-mhocko@kernel.org>,
 <20211019110649.GA1933@pc638.lan>, <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>,
 <20211019194658.GA1787@pc638.lan>, <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>,
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>,
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>,
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>,
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>,
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>,
 <20211020192430.GA1861@pc638.lan>
Date:   Thu, 21 Oct 2021 21:13:35 +1100
Message-id: <163481121586.17149.4002493290882319236@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> > >
> > > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > As I've said I am OK with either of the two. Do you or anybody have=
 any
> > > > > preference? Without any explicit event to wake up for neither of th=
e two
> > > > > is more than just an optimistic retry.
> > > > >
> > > > From power perspective it is better to have a delay, so i tend to say
> > > > that delay is better.
> > >
> > > I am a terrible random number generator. Can you give me a number
> > > please?
> > >
> > Well, we can start from one jiffy so it is one timer tick: schedule_timeo=
ut(1)
> >=20
> A small nit, it is better to replace it by the simple msleep() call: msleep=
(jiffies_to_msecs(1));

I disagree.  I think schedule_timeout_uninterruptible(1) is the best
wait to sleep for 1 ticl

msleep() contains
  timeout =3D msecs_to_jiffies(msecs) + 1;
and both jiffies_to_msecs and msecs_to_jiffies might round up too.
So you will sleep for at least twice as long as you asked for, possible
more.

NeilBrown


>=20
> --
> Vlad Rezki
>=20
>=20
