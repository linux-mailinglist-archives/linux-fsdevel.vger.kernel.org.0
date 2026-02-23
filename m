Return-Path: <linux-fsdevel+bounces-77953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKNaKZdWnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:31:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84337176F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 089FC305CA20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C41A3166;
	Mon, 23 Feb 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKhxjY68";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lCvKj4WC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E523A1D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853067; cv=none; b=d2dLBD9oMqVoLz3P1yHt4NCaQm/Vh3SmMDqIiiov80kMcRWmCdFmXvxf/77/iqVqDCmhdsNlgdwtkqxjGAoYftwX1JDVCsIE/A4PUv/B+IKQ92gpfTBcl3KE/K0Flw74d9oEj+C/C6Uc/UZOUcOxpl38hbNdNKGRsDwEjrCz9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853067; c=relaxed/simple;
	bh=poGA6bo1jLXsV/w23+mdRU7Cm6PVshK+XcjhPgUMDlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBnipuy0dtLaVq603kCvBg2pENhTw3/bQGfyj60OEBs8gBNtska3QQEI44ZyZZ2yx5sqWc3n6po56mhfDLV1a5SaTqu16a6clKWTQsCBv2F1HCYzXlVTQuBP9y8mkzy23nm83r/dBS4P8MxQq4pUOq/JPtSzOMeBBpEfmC8oKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKhxjY68; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lCvKj4WC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771853065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksBMn2vFs5bfQS6gxZSFoOu9S+2Bm4FmVN3N5GLrC7g=;
	b=fKhxjY68o5vEz0x9vVoXuHvjrrL6OU9jNXF7EnLdwV3+M/4mKuw1yheLV+YilMWq/YillJ
	/X7UWtPMfx2YLpqEW2+pgBzfgFn2pWok0LtnT9F0l179SI6AmQeG1NsK1Lillzr3tTfuQG
	ZLPHp6hD5r8h+C/rHMj0GigUXFXXIIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-XJyEZHlvMf2r0mnmJ4bCdA-1; Mon, 23 Feb 2026 08:24:24 -0500
X-MC-Unique: XJyEZHlvMf2r0mnmJ4bCdA-1
X-Mimecast-MFC-AGG-ID: XJyEZHlvMf2r0mnmJ4bCdA_1771853063
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso46503985e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771853063; x=1772457863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksBMn2vFs5bfQS6gxZSFoOu9S+2Bm4FmVN3N5GLrC7g=;
        b=lCvKj4WCveD433Dsw/xYiiqEEbiLFVim2z+wFeOXmAZca+PMmW8Cejks/z6sEFy/dt
         ylcB+MDifsnt+f3t/D23sT+HL8wwxmU5979aOSm9rGauTirS4Btgme6Gr+40yqp+kd4g
         /WJAHLSVkpqsLVkxqJc/L5ZHldrbB9D4djT3iaSZ/cGWkm3T/EGyLHSQ5NSSgiq98uCj
         eAIHIdCgV/XhYMTwrFADsNixwDuvxIWMapAe0QNv6FqiUNzxRI8GIGI9a3vBQagYdGe9
         Z70Hm3lkb4ko/RxBEHA2hj64Snhs330/O9Cfn6ogJsCuf5R/riMRoHtEwF2hXuM3xdzH
         gWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853063; x=1772457863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksBMn2vFs5bfQS6gxZSFoOu9S+2Bm4FmVN3N5GLrC7g=;
        b=ZXLGmgou6+In4Gw+1r9KZWIfCGLComBxA1NgXPiACRGSqivdPMWP0ieJnX+/yzScKh
         WxZpmqjw6RwsE8DtHapFKHjwdpq8o0mFFlaufT7bM6nGqo6tIHVlvmgzQPo72v9OzTSu
         GxWSRwYVk5sWohMlrT1WVg/AiRxcFwlGuxumsosjqE5AdsxY1iowUCcdxECpLN1Cf/4D
         etDdZP+OnXE9Lv/21FJV6NIBW281/LFr01VoT2E9cFyUZ5ZzFkruC6sTTnvyGw6vSrz4
         TF/pCAv/0ahSMdlU2u/xJCDV4p2Q4G/kBRKncwMKWl/u4JIe2Vl8p4cmqbT/mQdkjMlj
         DYnA==
X-Forwarded-Encrypted: i=1; AJvYcCXoO5vlYBfkREjVBYA0pMmme6ov5PAjOVDcEcGUU2wjAnmaIQF4oRLO8rEeX57srl1jbRcP4CFvWu67Wh9c@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpI5sLmufpqcfYPLR1saT2x6AOQjm+eukiCd7bE1P5okxNdpf
	zuLu+CINp/0Z0cHfHtutBawMmNORBgxsbuVnGCBVSIEccy3cNuANcB9JnKRRJY+KzCJ9l1uIdqW
	6wwTjodi3UEeY7/jDiM7wslhLpFx9QHpveqvmZPlWQj7v7EgpFe8aEeFJ/tB8GhXdCQ==
X-Gm-Gg: AZuq6aLENHSxvQwEHB8V/tRspgP8H3/WcwsC/3fXXa9kVinaiZBDwCVsQh/uvp4CbiD
	aoLChk5ykzB5TSeRi9m04Cfw/ZKjoiIcUhlGCEU1E440RefRN1xCjbqW3zSRn9dRrT79N3kGLVX
	OSzYQBV9JZrJ4NNxfKaiAK3jcZiKnYNPmlgFW5W8Bewy+S0fZn6ZNU0D3WfGRZjJ6S8VRKldCQJ
	yCuzEAs1A+GJQK83ObZ17X2nHhOwzz3/AH6YxDF9nDdAvaOpFChnGJAWq5Vapza00WrTdC7Octf
	XXau70wrZR+/oQKg2eV+Bkozaj6apiAn8cXT6wl11ehKT6K6vP7YPfAcCENUF77+khM5V8/e5bN
	57qKs7yDk2Jc=
X-Received: by 2002:a05:600c:1f8f:b0:480:4a4f:c363 with SMTP id 5b1f17b1804b1-483a95fb25dmr151444985e9.9.1771853062845;
        Mon, 23 Feb 2026 05:24:22 -0800 (PST)
X-Received: by 2002:a05:600c:1f8f:b0:480:4a4f:c363 with SMTP id 5b1f17b1804b1-483a95fb25dmr151444465e9.9.1771853062370;
        Mon, 23 Feb 2026 05:24:22 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a42cd49fsm122198985e9.5.2026.02.23.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:24:21 -0800 (PST)
Date: Mon, 23 Feb 2026 14:23:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 06/35] fsverity: pass digest size and hash of the
 empty block to ->write
Message-ID: <gjehtg6itdgjysiksqmccrelsqev7so7366zmfer62tgse7u6d@2kucmtmrfq2t>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-7-aalbersh@kernel.org>
 <20260218061834.GB8416@lst.de>
 <wl5dkpyqtmbdyc7w7v4kqiydpuemaccmivi37ebbzohn4bvcwo@iny5xh3qaqsq>
 <20260219055857.GA3739@lst.de>
 <20260219063059.GA13306@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219063059.GA13306@sol>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77953-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84337176F2B
X-Rspamd-Action: no action

On 2026-02-18 22:30:59, Eric Biggers wrote:
> The hash could be stored in that same allocation for salted files, or as
> a fixed value in struct fsverity_hash_alg for unsalted files.  Then at
> least unsalted files wouldn't use any additional memory per-file.
> 
> - Eric

Hmm, but fsverity_hash_alg is global const, and anyway we will
always have merkle_tree_params::hash_alg::zero_digest as fixed space
for salted/unsalted.

-- 
- Andrey


