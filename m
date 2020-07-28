Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97E230C63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgG1O1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:27:11 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:55393 "EHLO
        18.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgG1O1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:27:11 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 10:27:10 EDT
Received: from player696.ha.ovh.net (unknown [10.110.103.132])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7B6911D1A0A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 15:09:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 7FFC414CE4113;
        Tue, 28 Jul 2020 13:09:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002b58cb82c-eff5-4db6-a291-f5e5dc050bf0,96196EA346850768E7E70500A314E772A5EF2CEB) smtp.auth=groug@kaod.org
Date:   Tue, 28 Jul 2020 15:08:59 +0200
From:   Greg Kurz <groug@kaod.org>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, stefanha@redhat.com,
        mszeredi@redhat.com, vgoyal@redhat.com, gscrivan@redhat.com,
        dwalsh@redhat.com, chirantan@chromium.org,
        Christian Schoenebeck <schoenebeck@crudebyte.com>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200728150859.0ad6ea79@bahia.lan>
In-Reply-To: <20200728105503.GE2699@work-vm>
References: <20200728105503.GE2699@work-vm>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2555511317785123122
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhuddtveelgeevffetjeffjeffieevhefhteehheehhfeuudehfffftdeijeeukeenucffohhmrghinhepvhhirhhtihhofhhsrdhsvggtuhhrihhthienucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Jul 2020 11:55:03 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> Hi,
>   Are there any standards for mapping xattr names/classes when
> a restricted view of the filesystem needs to think it's root?
> 
> e.g. VMs that mount host filesystems, remote filesystems etc and the
> client kernel tries to set a trusted. or security. xattr and you want
> to store that on an underlying normal filesystem, but your
> VM system doesn't want to have CAP_SYS_ADMIN and/or doesn't want to
> interfere with the real hosts security.
> 
> I can see some existing examples:
> 
>   9p in qemu
>      maps system.posix_acl_* to user.virtfs.system.posix_acl_*
>           stops the guest accessing any user.virtfs.*
> 
>    overlayfs
>       uses trusted.overlay.* on upper layer and blocks that from 
>            clients
> 
>    fuse-overlayfs
>       uses trusted.overlay.* for compatibiltiy if it has perms,
>       otherwise falls back to user.fuseoverlayfs.*
> 
>    crosvm's virtiofs
>       maps "security.sehash" to "user.virtiofs.security.sehash"
>       and blocks the guest from accessing user.virtiofs.*
> 
> Does anyone know of any others?
> 

Hi Dave,

Sorry, I'm not aware of any other example.

Cc'ing Christian Schoenebeck, the new 9p maintainer in QEMU in case
he has some information to share in this area.

Cheers,

--
Greg

> It all seems quite adhoc;  these all fall to bits when you
> stack them or when you write a filesystem using one of these
> schemes and then mount it with another.
> 
> (I'm about to do a similar mapping for virtiofs's C daemon)
> 
> Thanks in advance,
> 
> Dave 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

