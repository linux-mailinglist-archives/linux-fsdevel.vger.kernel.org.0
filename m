Return-Path: <linux-fsdevel+bounces-33314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0EC9B7324
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 04:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47421F230ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 03:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799112D1FA;
	Thu, 31 Oct 2024 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="PyK8HNhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFEPOCgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A721BD9DC;
	Thu, 31 Oct 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346502; cv=none; b=CcjvaQcMFwSl05WxdQb2pURVYWlBm4FbuHTvkFkoplzEl5Fo64/Umq0GpFf44QwmQ1MC1a922uJBRnu98xrDogRgN8HybcmAiBhGytWGS4jyow5+3h9yvCc4ItQMwrkuh8zR9zgim94+eEJ6LXJ3D5+CWAKm7H1o04lSr8k+E7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346502; c=relaxed/simple;
	bh=0jUZfXGI5qpTB0s6kN6cS8lgMmC7yLOFmqlcI2IrZ9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFOv57Z8eEuKzb2LasSnlOnZSpGkJaluuLZQhuOPHhBYX353L4MML3OIpLsm2QxllEBOQdJXkV+O15wLmRHVODL6UVIDo13zklVQV5CLWIg349gGErbgKWtcj6wS7MVWvmc5TQtUA5Kll1y3Nt2354Wsivjp8u2XIkJ9f0SJ3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=PyK8HNhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFEPOCgH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F39171380231;
	Wed, 30 Oct 2024 23:48:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 30 Oct 2024 23:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730346496;
	 x=1730432896; bh=KN2UWDEaGGsmpJJ1ava58l8UF+I41eSZVzp7bkX27+w=; b=
	PyK8HNhcZZ+A8bA2ky914Qyx/pdYp3CGQ9QXi8oo3xxmiOdkTz8PAQ5H0yiz2/Qn
	pYsk23OBoS2y58xi4pae9lYZ6Xy0kQTci4Z0Wb1sY5NdwzLP8m1Rs7k6KLl71IYX
	foFSS1L8TNn0xNgONFHXrXUVAyr9lSWwaxuTzSY/AUeRyZiA8EkVoJqTqUiGS0GO
	Z+8RkWUEJ+yYdp8idj/6lPprwj/i7UnSljldtQKLTg4uviUZ7DvvuNtYJkb4Uifz
	wYfQJcu5/ZnLzlPR+YFTd7cDdQanTPYDGDYbdk0v/hCENnLoVJrEGsqiuZNRWu/s
	zIGsnqN0F+VOxRVFVwwlXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730346496; x=
	1730432896; bh=KN2UWDEaGGsmpJJ1ava58l8UF+I41eSZVzp7bkX27+w=; b=m
	FEPOCgHp0sK5TWiwWtF90jRw5tBoLLoLGPGIglNAx5sgNeOGzBL5XGi1gSSppGfF
	EcODxehttZhfWscRtlimEDtpNYXKa48f3MK58ICHWtYCOWFYPHmdjyJbkGfPFYNM
	EuVxliFFVd/iCt3rKFCr0/+xNRTV4LNyueATknMzVvqxYrpdeApMykMC8thVmAfu
	+ZcMKxpT1HVdv4bCJbFuOeSClr4LFdeZatkwkBTN5XS6k8tCh+FEBB3Wzzpm9SeB
	Vx1Bz25UAwZhGGtShvYwcXlYG54cuKNDurXy2X7XpsdV4mg0BZENE0/HZu5JI0i+
	R77ornQ35CMhT4B5DEYnw==
X-ME-Sender: <xms:AP4iZ6ZrbPhsPxUmdwCEZN8gwnHdbd_CD5Z2qpqT6qU7X0Ch1_HEoA>
    <xme:AP4iZ9YV36eyeix1BTd2LCe7KGTgDFdKATTLPy8Di6-jJelag0AhF0yuaQswQSH10
    77KATtm1IzdoBEsxB8>
X-ME-Received: <xmr:AP4iZ0_oQpTjmWV4GSt-S2KGPbaRMfSbyS4JvN-3ULRyUZZ0wuZJO7agxyb65w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiilhgrnhhgsehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:AP4iZ8pP6ywRRlqN2bjeNfJCjTt5lhbcEJyNJVCiyLcWhuToLuynMQ>
    <xmx:AP4iZ1o5XIA-ivbRH3wzRmUZ5yhiOs7HI9uwfCjGa2l1-cI59FM4lA>
    <xmx:AP4iZ6Tjqe5EPnJhtzq-uVGFD-KtOa6tQk4JYBrQtGHJqRqrU6agnQ>
    <xmx:AP4iZ1rWqMbH4E2BWLOdKAMU2JWvRXF_VyItpGRk34PX266vnWnxyA>
    <xmx:AP4iZ2cGBJ9YS2OB_vYQgEMwAaY-pp7uevUs07To8xNLA7o868LnjXSe>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 23:48:16 -0400 (EDT)
Message-ID: <9f489a85-a2b5-4bd0-98ea-38e1f35fed47@sandeen.net>
Date: Wed, 30 Oct 2024 22:48:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2 (new
 mount APIs)
To: Christian Brauner <brauner@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 7:22 AM, Christian Brauner wrote:
> On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
>> Hi,
>>
>> Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
>> specific mount options), e.g.
>>
>> FSTYP         -- overlay
>> PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
>> MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
>>
>> generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
>>     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
>>     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
>>     @@ -1,5 +1,5 @@
>>      QA output created by 294
>>     -mknod: SCRATCH_MNT/294.test/testnode: File exists
>>     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
>>     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
>>     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
>>     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
>>     +       dmesg(1) may have more information after failed mount system call.
> 
> In the new mount api overlayfs has been changed to reject invalid mount
> option on remount whereas in the old mount api we just igorned them.
> If this a big problem then we need to change overlayfs to continue
> ignoring garbage mount options passed to it during remount.
> 

It fails on /any/ overlayfs-specific options during reconfigure, invalid or
not, right?

        if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
                /*
                 * On remount overlayfs has always ignored all mount
                 * options no matter if malformed or not so for
                 * backwards compatibility we do the same here.
                 */
                if (fc->oldapi)
                        return 0;
                
                /*
                 * Give us the freedom to allow changing mount options
                 * with the new mount api in the future. So instead of
                 * silently ignoring everything we report a proper
                 * error. This is only visible for users of the new
                 * mount api.
                 */
                return invalfc(fc, "No changes allowed in reconfigure");
        }

        opt = fs_parse(fc, ovl_parameter_spec, param, &result);
        if (opt < 0)
                return opt; 

And because today mount(8) will re-specify everything it finds in
/proc/mounts during remount, presumably that's why all these tests are
failing - even a simple remount,ro will fail:

# mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merged
# strace -e fsconfig mount -o remount,ro merged
fsconfig(4, FSCONFIG_SET_FLAG, "seclabel", NULL, 0) = 0
fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "lower", 0) = -1 EINVAL (Invalid argument)
...

Surely mount -o remount,ro should continue to work for overlayfs when the new
API is used.

Maybe there's a third way: accept remount options as long as they match
current options, but fail if they try to modify anything? Not sure how tricky
that would be.

(side note: it's a bit worrisome that there is probably no consistency at
all across filesystems, here.)

-Eric

