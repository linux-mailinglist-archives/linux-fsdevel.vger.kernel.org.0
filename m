Return-Path: <linux-fsdevel+bounces-69921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70FC8BDDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600EB3A5D42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1033EB04;
	Wed, 26 Nov 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Rq0UZgyj";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ExHoT/Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD6270ED7
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189122; cv=none; b=iEDXDgBW1Yhq0IsGuk3C7n+WOCAfT8EwbRSHOtloWgCSzi7uaFQcIDQ2HdJ7La121BIK6spSs9MzCyxAqO7FqCdPPiZGU9HJjBJMobTpRY1rZsnlzzjvy5HQX2yYHy60mFjpQhnKyDQedZnAH+i0mzA+mPo+1KNxZSKAVq9WZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189122; c=relaxed/simple;
	bh=kt0GqCOQ8nKevzgl1DYg31XjX+YvCvRrK1pWPVUWsdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9vvfYoUV7q7mA5lRo5UMUDERw4Bk8t3EHVjUGBAQAF57OXEQnrFt1rF2JdD18Dxxyg1Mugu7NJctURpBTpNyzrK3w7v550a67aH4NDt2+dROGZJb3Gs/Sn2/V04ScfWv7FaziPmF/60KsX5RsUqlfqnZPqN61Oy7sbOdmZiiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Rq0UZgyj reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ExHoT/Bk; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1764190019; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=oo0M4ydtK5Fa6pnW+MiV3ZxPH6O6l9/HYBAD3BWh0eE=; b=Rq0UZgyjcX/l4r7pGovaAKt3kP
	uRNCE1QQGsXYHND0F23daEnBSeA6V9FuMH1Q7pkYfVdvunhywIEZyr18MO/U0aQ4eWT4W2zQ5q+jx
	5xnl+hycwc00lVGhg4Prj/dHlwA+YInm9FrLF555LaSGOa1VRS2KI3H+LysT1T9+3xopj0glJ+lhV
	5ygfoQz/QcYobb8lXCQNZDCzb+Es2DYHQjOErhhJOVDFRy8kMb23HezYYysxE0x7tjdi4y7GamTpJ
	NJLIaMRamZSiDF+eXBuR/zPfizQAd75q2YzCPdmASqhr27WT0LMzVTHl/o/ZMPmqotoDbqb60gTFs
	yMcWKODA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1764189119; h=from : subject
 : to : message-id : date;
 bh=oo0M4ydtK5Fa6pnW+MiV3ZxPH6O6l9/HYBAD3BWh0eE=;
 b=ExHoT/BkLG1JZWawAgkP3cEe2E2VPKko6SxS0MU+krn1rUYeY5lvcL24fS8PbT/A+X1L2
 IqV53PyJXx7DXEP1+y46Wv2DpvNW8+X7mRxRKW4j33421jrGLrs2sYRGG6QyeqcGLh6KsNv
 ErA/xDOVlnJe7xvDyEaNRNLoAzgwNMly/mc0TgCPpd3u0D1Hcd/aqwppwBhyv0VcvlOLSgv
 jzYDgbI2bL/GRIVybjlaA4wUop81ntkDmbUZ9YVAJVKacUN0rW36GrzKCvU86OltYh9edpQ
 SCTuNHRy8isj7TH6jOnU5dB+Vo5F2cmLcECj+4TH/IKCEzMhpKJ9m14BlnTA==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vOMAr-TRk23d-DV; Wed, 26 Nov 2025 20:31:37 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vOMAq-4o5NDgrnPxr-mjHh; Wed, 26 Nov 2025 20:31:36 +0000
Date: Wed, 26 Nov 2025 21:16:14 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aSdgDkbVe5xAT291@pilgrim>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOzT2-e8_p92WfP-@codewreck.org>
X-Smtpcorp-Track: iINeWYempQHF.fs8ddMn41GM0.MF_58AaUv77
Feedback-ID: 510616m:510616apGKSTK:510616sykM-zowXn
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi Eric, Dominique,

On Mon, Oct 13, 2025 at 07:26:35PM +0900, Dominique Martinet wrote:
> Hi Eric,
> 
> Thanks for this V3!
> 
> I find it much cleaner, hopefully will be easier to debug :)
> ... Which turned out to be needed right away, trying with qemu's 9p
> export "mount -t 9p -o trans=virtio tmp /mnt" apparently calls
> p9_virtio_create() with fc->source == NULL, instead of the expected
> "tmp" string
> (FWIW I tried '-o trans=tcp 127.0.0.1' and I got the same problem in
> p9_fd_create_tcp(), might be easier to test with diod if that's what you
> used)
> 
> Looking at other filesystems (e.g. fs/nfs/fs_context.c but others are
> the same) it looks like they all define a fsparam_string "source" option
> explicitly?...
> 
> Something like this looks like it works to do (+ probably make the error
> more verbose? nothing in dmesg hints at why mount returns EINVAL...)
> -----
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 6c07635f5776..999d54a0c7d9 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -34,6 +34,8 @@ struct kmem_cache *v9fs_inode_cache;
>   */
>  
>  enum {
> +	/* Mount-point source */
> +	Opt_source,
>  	/* Options that take integer arguments */
>  	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
>  	/* String options */
> @@ -82,6 +84,7 @@ static const struct constant_table p9_cache_mode[] = {
>   * the client, and all the transports.
>   */
>  const struct fs_parameter_spec v9fs_param_spec[] = {
> +	fsparam_string  ("source",      Opt_source),
>  	fsparam_u32hex	("debug",	Opt_debug),
>  	fsparam_uid	("dfltuid",	Opt_dfltuid),
>  	fsparam_gid	("dfltgid",	Opt_dfltgid),
> @@ -210,6 +213,14 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	}
>  
>  	switch (opt) {
> +	case Opt_source:
> +                if (fc->source) {
> +			pr_info("p9: multiple sources not supported\n");
> +			return -EINVAL;
> +		}
> +		fc->source = param->string;
> +		param->string = NULL;
> +		break;
>  	case Opt_debug:
>  		session_opts->debug = result.uint_32;
>  #ifdef CONFIG_NET_9P_DEBUG
> -----

While testing this series to mount a QEMU's 9p directory with
trans=virtio, I encountered a few issues. The same fix as above was
necessary, but further regressions were also observed.

Previously, using msize=2048k would silently fail to parse the option,
but the mount would still proceed. With this series, the parsing error
now prevents the mount entirely. While I prefer the new behavior, I know
there is a strict rule to not break userspace, so are we not breaking
userspace here?

Another more important issue is that I was not able to successfully
mount a 9p as rootfs with the command line below:
 'root=/dev/root rw rootfstype=9p rootflags=trans=virtio,cache=loose'

The issue arises because init systems typically remount root as
read-only (mount -oremount,ro /). This process retrieves the current
mount options via v9fs_show_options(), then attempts to remount with
those options plus ro. However, v9fs_show_options() formats the cache
option as an integer but v9fs_parse_param() expect cache option to be
a string (fsparam_enum) causing remount to fail. The patch below fix the
issue for the cache option, but pretty sure all fsparam_enum options
should be fixed.

----
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index a58abe69ec7a..e4e8304e5934 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -120,6 +120,21 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	{}
 };
 
+static char const *p9_cache_to_str(enum p9_cache_shortcuts sc)
+{
+	char const *cache = "none";
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(p9_cache_mode); ++i) {
+		if (p9_cache_mode[i].value == sc) {
+			cache = p9_cache_mode[i].name;
+			break;
+		}
+	}
+
+	return cache;
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -144,7 +159,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%x", v9ses->cache);
+		seq_printf(m, ",cache=%s", p9_cache_to_str(v9ses->cache));
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);
----

However same question as above arise with this patch. Previously cat
/proc/mounts would format cache as an hexadecimal value while now it is
the enum value name string. Would this be considered userspace
breakage?

Thanks,

-- 
Remi

