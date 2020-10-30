Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A902A0B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3QYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 12:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3QYn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:24:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EE020A8B;
        Fri, 30 Oct 2020 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604075082;
        bh=JsEAfGGgoOV85RaVdC5H8YDmaqo/M0m8S3exAQEGvmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk0rODp+2RGw0c85aihYBKBFpCgl/1h4tNccV3Iq5LT510uI7O/GYH9VqdtGLy4dy
         9bNAg+TJWTLJj6geLwsawPpm4jO09ieIhXr3+q/vTB+AoeYcWBjjpPh0CC+KOtUbHp
         TADzb4NTvF7Wl2F6WUuuGARezXxw4Uv96M3I5u8Q=
Received: by pali.im (Postfix)
        id 39EB486D; Fri, 30 Oct 2020 17:24:39 +0100 (CET)
Date:   Fri, 30 Oct 2020 17:24:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>
Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20201030162439.byd6p3flwjyimuae@pali>
References: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
 <20201030152450.77mtzkxjove36qfd@pali>
 <5313baaad14c40d09738bf63e4659ac9@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5313baaad14c40d09738bf63e4659ac9@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Friday 30 October 2020 15:51:10 Konstantin Komarov wrote:
> From: Pali Rohár <pali@kernel.org>
> Sent: Friday, October 30, 2020 6:25 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> > willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmstone.com; nborisov@suse.com; linux-ntfs-
> > dev@lists.sourceforge.net; anton@tuxera.com
> > Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation by Paragon Software
> > 
> > Hello and thanks for update!
> > 
> > I have just two comments for the last v11 version.
> > 
> > I really do not like nls_alt mount option and I do not think we should
> > merge this mount option into ntfs kernel driver. Details I described in:
> > https://lore.kernel.org/linux-fsdevel/20201009154734.andv4es3azkkskm5@pali/
> > 
> > tl;dr it is not systematic solution and is incompatible with existing
> > in-kernel ntfs driver, also incompatible with in-kernel vfat, udf and
> > ext4 (with UNICODE support) drivers. In my opinion, all kernel fs
> > drivers which deals with UNICODE should handle it in similar way.
> > 
> 
> Hello Pali! First of all, apologies for not providing a feedback on your previous
> message regarding the 'nls_alt'. We had internal discussions on the topic and
> overall conclusion is that: we do not want to compromise Kernel standards with
> our submission. So we will remove the 'nls_alt' option in the next version.
> 
> However, there are still few points we have on the topic, please read below.
> 
> > It would be really bad if userspace application need to behave
> > differently for this new ntfs driver and differently for all other
> > UNICODE drivers.
> > 
> 
> The option does not anyhow affect userspace applications. For the "default" example
> of unzip/tar:
> 1 - if this option is not applied (e.g. "vfat case"), trying to unzip an archive with, e.g. CP-1251,
> names inside to the target fs volume, will return error, and issued file(s) won't be unzipped;
> 2 - if this option is applied and "nls_alt" is set, the above case will result in unzipping all the files;

I understand what is the point and I'm not against discussion how to fix
it. But it should be implemented for all filesystems with UNICODE
semantic, so behavior would be same.

For user application point of view, behavior of vfat, ntfs, udf and ext4
(with UNICODE support; see below) in handling file names should be very
similar (or exactly same if fs tech details allows it).

> Also, this issue in general only applies to "non-native" filesystems. I.e. ext4 is not affected by it
> in any case, as it just stores the name as bytes, no matter what those bytes are. The above case
> won't give an unzip error on ext4. The only symptom of this would be, maybe, "incorrect encoding"
> marking within the listing of such files (in File Manager or Terminal, e.g. in Ubuntu), but there won't
> be an unzip process termination with incomplete unarchived fileset, unlike it is for vfat/exfat/ntfs
> without "nls_alt".

When using ext4 in default mode then it really does not apply here. But
I wrote that it applies for ext4 with UNICODE support. This mode needs
to be first enabled for directory, it is relatively new feature and I do
not know if there are users of it and how many people tried different
crazy test scenarios with normalization, etc...

> > Second comment is simplification of usage nls_load() with UTF-8 parameter
> > which I described in older email:
> > https://lore.kernel.org/linux-fsdevel/948ac894450d494ea15496c2e5b8c906@paragon-software.com/
> > 
> > You wrote that you have applied it, but seems it was lost (maybe during
> > rebase?) as it is not present in the last v11 version.
> > 
> > I suggested to not use nls_load() with UTF-8 at all. Your version of
> > ntfs driver does not use kernel's nls utf8 module for UTF-8 support, so
> > trying to load it should be avoided. Also kernel can be compiled without
> > utf8 nls module (which is moreover broken) and with my above suggestion,
> > ntfs driver would work correctly. Without that suggestion, mounting
> > would fail.
> 
> Thanks for pointing that out. It is likely the "nls_load()" fixes were lost during rebase.
> Will recheck it and return them to the v12.

OK!
