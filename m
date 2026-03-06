Return-Path: <linux-fsdevel+bounces-79670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAKWCXZSq2n3cAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 23:17:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AD22845A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 23:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9479630305DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79135028C;
	Fri,  6 Mar 2026 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTRQIGYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8334F46B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835437; cv=none; b=S6eB9f3tIfJn/ZxtA9JnKkBzmNtJ0FZwzXntKJaWhXYV1nHmRcU7anEynJrQgWrZ4S7KKZKed9StNI6ygy6P4JpTpr3tmUZipmacONILUASz77dJ5XeLvomqZqglSnGOc86hxNYuteCC701uVeoGqVm1dswfjAMt/+zbkmXaZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835437; c=relaxed/simple;
	bh=z5tFPrwfWpBk7qXUwd+YaGYOmkJPxDzwKZc6JelInEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBj7BpRFtYsqWvAvY3TJOfK3ZMJKVQm99MRtCaq6dWFxT3ePyUstXPOs8fgkPa2BcXY2PTlCQzmSG0Lk5kmUkdfrAN3sHHS8rzoV9bIlFFoHtydV2y/mraEi/UQSyUI02uFWsg+bnUtWuPGXcNDvDJU6bwVnL+kAhpPdvDFzLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTRQIGYR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so116720105e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835430; x=1773440230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIiYq0bgub6obyob1MzymOe1qu/acfDeFowYjF2iTbU=;
        b=OTRQIGYRcyGRMTai9QUsdtpwi9e/t7quBxfJgFcoCM/XNd34RQjVDphU0wzqMjPmbN
         lpLYQljuhmBqlWLGV2dWFTMhzDdJ9HvgGHIlIq/IiSWd3HjAphbteMNeYB0rh600bUyk
         lNRetIisxv3W5/MMK8+O3I+1xAjUDFHnIE5vzBi12gv/K7QSPLaY7Hi6Me5WPFgVhIQp
         7/UPEsDj2B2d92ssV3jQgwwH9uLwUMGid/fGuWn/ZZKPO4YuCnzyMeaCuwCps6ZeLBu8
         Zne79CFRM9nBPCG8JWEznqdmVMoxtlcVwB2YhFlEPyxj1lKb4xmtQC0zSr2ldCKNz1o1
         b0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835430; x=1773440230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIiYq0bgub6obyob1MzymOe1qu/acfDeFowYjF2iTbU=;
        b=n4X6TZPt+OWRMIGe8rARYyG3U42Xq5R4Qw5bdwgxmuRiPp8qRPZb6RPCH6QJyzYyDX
         kiADonYAq1I8pU2ubiL/KGRH04CMBXKWqa9AIoLWPib4heGKUj1zqHmKHkuTdERjldvm
         bAcr5B0CYRRjVgT3XweEAIByvfNv7gaV3kvYkE6/QuZASj3ezIN/46nu+Qd5GQh4IAUi
         uDiX7qGCLwE9NtLfOlJgayYQ+MTHlz7ZRMx2oisP3FhoTv7i2r4Qy4mLIwIpfFEZAlJA
         lSk2vn4NgpwdKdqng1srfNOxcHoI5MBdxeSvWfHM0CWumgVHdkVtmUSJHM/hHgXor/MQ
         irxA==
X-Forwarded-Encrypted: i=1; AJvYcCVsdHH1xYiRhqJ99dsbRAMFWVwNo4+K1Ia2MsCmokBu9abZo/oBb/THmo1Dg6CW8a0jr9J3C3ZRJCchC/Cn@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEd31RnfTtSBNtBh8EV2cf3wD9up7HRxKDmGP1v2wlsQfyceK
	kdgPJKsZVGDwFc7GX3+gCdyttKctat8X5sLAkaFqKENPDdFqPNB/XsPF
X-Gm-Gg: ATEYQzzUOF+dsZpV1BQ59M3OoYdCOslTKgvtvqKtskC9ppfFdbz3TkS6s3wEiPUS48R
	jEROh1asM/pvygrXdY3kigDQtw5rvpUTx6AQjWefVVn1DTL2nbJGpOTcCnApsqCncn/eSFGrHh4
	vmx7h5clvTRrm70gktr87QsnYDgReaTCzcbQ3cWAPSeqng0T8jiBHcVLiPidkH5avW65Fxnvd6q
	ovhHBZHkj5HXDLEX/yq7RcMqjw8X5F7LbgrgfNrkXFeICudCYtXqUlvlkd/8P2x3tdNEcwZa0SU
	sWnfzRhuQ+RwNdCIJIQJloBtPE01T7GFzVzdcSHMz5k6XRGqqBolbW9R1ktkjd5QaprweEPTwF2
	jKHHgPHELdWIKacSPQLlycjR4w+7Jp/npnIZF2IgRzW4tF6FDBc97fEVu+U+e8HsgWevObFcInJ
	RIZRRwOCg/Hk9vfdOAbvciV3EBbgkQ2lZTEtcEvrUC7OfMx4pBkCPwQfMNQSC/L0OwAXTln1A=
X-Received: by 2002:a05:600c:3e08:b0:483:7eea:b172 with SMTP id 5b1f17b1804b1-485269675a7mr67410695e9.23.1772835430206;
        Fri, 06 Mar 2026 14:17:10 -0800 (PST)
Received: from f (cst-prg-92-188.cust.vodafone.cz. [46.135.92.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485244b6e9esm47581535e9.5.2026.03.06.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:17:09 -0800 (PST)
Date: Fri, 6 Mar 2026 23:17:02 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Message-ID: <vuorddxuncggijjthaeilz26jd6tnbgf6wjicv3n3pt52ceyv2@fijkpocwutaw>
References: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
X-Rspamd-Queue-Id: 832AD22845A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79670-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.865];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 08:27:01AM -0500, Jeff Layton wrote:
> Christoph says, in response to one of the patches in the i_ino widening
> series, which changes the prototype of several functions in fs.h:
> 
>     "Can you please drop all these pointless externs while you're at it?"
> 
> Remove extern keyword from functions touched by that patch (and a few
> that happened to be nearby).
> 

Is there a reason to not straight up whack the keyword from *all* funcs in
the file?

