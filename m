Return-Path: <linux-fsdevel+bounces-70841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6119CA8A4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380E830BEA45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FEA34679D;
	Fri,  5 Dec 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHT8GwCv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Smlf3LTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4833F8B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954882; cv=none; b=COjV0l0dgUl9FqarVej52BDHRPHPNVCcCbsEKrtT2b6gYz4gtD9MVLhLYQX5QXAnv8bCBRZNY1FzSIJFba05DQEK2KYa1zR3rh6QYkNxGHVA6xVzT8wHrk6LFmcxqzPhxNJVpZFSa+zk0rU7QirX6Kolhiiz01KxGop9X1h5O+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954882; c=relaxed/simple;
	bh=h1Z+BVnBoVaSCJl0VcIXxwMnC9zg05UdlhBoero1z5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGOt1Hb+FqrvUA2S70edYjDpkWhpDaUASZUwTO/VD8DXM+e05wtqDNNN0vHO9+WCnShS038YVbALfKVHQ+en1ruwJnLArgRmXyBQ1nwL9aQfsupX0fvDFOvHO0n+BKJYCbi46NL9jrXVoh1WYHafM0sFotpGgDjzE5zlxLyCfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHT8GwCv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Smlf3LTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764954871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
	b=jHT8GwCv9C2CZ0tsR/n7tpydLI1T7Wuf8TRsdTmArveAx7X5fDw89wk3oScSeXSjYd3LO+
	lc8wSprQbshk+WjZxUW9rDXmS8Zu0NurcepYY+dlnfYgGI+zBc+5X3jMsQ4tq/SYqPPkDR
	u41M+t1vhzuFAo7BcuDX1b2G2drR9Zw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-VWKEhnZaPsKoBOvi15Jsgw-1; Fri, 05 Dec 2025 12:14:28 -0500
X-MC-Unique: VWKEhnZaPsKoBOvi15Jsgw-1
X-Mimecast-MFC-AGG-ID: VWKEhnZaPsKoBOvi15Jsgw_1764954868
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso4459886b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764954868; x=1765559668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
        b=Smlf3LTgRNPtTGg0238/qvV6VXoaQRbavEvP+PGVEKNZ8EWrOL4Yl4wfVnULUpznxO
         haxiwffd02ElDPx1NhAQz2NbxryUJ/krkaCSPUcVySiJCtaMVIIviZlybvtr/Vefo8G+
         TMDf4azv5ec2VwExP28TuMJdndccU3qSv9DrqZiaLEHSNJoLnuEXU4im41vZQPBNNeNN
         0LXI0m25MogB2PEAXth2PHp8jysOks9e1dAFP4Y19o9SNrYNnL4mZAcKmcBO/orCB6zI
         FvlFLuuJyKgoYxrtZNCFBhAO7zWjB7PvivUnHo+EslBr0jAMERmQTxXl4R7dZnyyJzQa
         5KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954868; x=1765559668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
        b=r4JcA+sqRftMxjAFmEQHVgBE7fodHNVbRyk+PbKcXM5o+dkV/PQY+pat2am4KsQ9Ve
         IFMgLYqUg+QPaKHvpmWncPL2u06mqRX1OIx9/qxNi+oHbhAHbmvMBMHc/JRVN5YQSHEx
         DRWeDdPD6Ojw2iG/eq9YU6IxZO8qNsnYQ0u1NTUPV216G/7pQkE1hpTOtCIbNsBa2a6p
         SttOBu1H5g/QP+VqgHmLUwItnjgSLblFD3s4mDAkkzhUXBffNULf9Mjrdkg8m5Cu+96I
         V5WCTAcnOLLJf42IzE45dqoBSVAGK06jp2ehoZ3hLJK/d+Q065IbUf5cTTY6auKcC8eS
         aXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUtu5rdk3jzEGRkCemCVdirg8gzb/E+/F7FTVnRaoxpMAb1haQ4+0Kqs8pcMznaJrHPZ5w5OSRcM7yGvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwweK4lf67Ez3M52uXiwuCxKcj6QxcNU663qzVulUgdZuAvzt5/
	FVtjazvn5ARS5YCO+oVoVSePtH0gwvB64Df8Sizj9/UyrPWCfKUAPRyyJgCpKvokmnkbgGY3G/E
	Dez445qpY6T5KZKW7o3BDlKH+joRsx/s5ddArySOxbXkfnWTxQkWJl8ZCbN6VZPq3U7U=
X-Gm-Gg: ASbGnctJzLMcFkLoVxXXuMCqNv7/M8He/NMzaWQ2J0j6Jz8gF03EjYH4WejcBf/ujd5
	GSLr+I8DaqbXlqNMjqanS2tNO6wo+DoZNYMGGXmWnXbT0o/ZX8H/zNUDcs+5lOU/3N6Bj4elkGD
	oKy04OeNgIWjHKTL+oO5L8+xNHOrOe8IBNB7Zc+KGaj5hALPmeiOz3NwrQotmzRVpBjt5Opej7F
	bU8YRqPyIdjjGMI8IE7rOMHbdeHffFfkfBvxBR5Q9uoXiRgZj9iYwBoFzBuis2icrPjDu8JKqgE
	VgQ0Cm4aEJGdGWFYp0pTPDqcZu7KZx8KndnHUYTvnitFgQVtuHuVdt6Xgw4utCc9w25s/Cj6xlP
	T506/9kkgLhOeQA7OV1wBU6E9hRpQYTh2SvuFIkSE9wwbOUXHng==
X-Received: by 2002:a05:6a00:2283:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7e8443391b8mr583957b3a.33.1764954867798;
        Fri, 05 Dec 2025 09:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTlg6can+HvA+4fi3e6HCk+YQednzlBI3QtVrdw1y9Yfq4QdKTK3ndJwtYc5QarvY8VO9kow==
X-Received: by 2002:a05:6a00:2283:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7e8443391b8mr583934b3a.33.1764954867346;
        Fri, 05 Dec 2025 09:14:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae03513fsm5765462b3a.43.2025.12.05.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:14:26 -0800 (PST)
Date: Sat, 6 Dec 2025 01:14:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 1/3] common/rc: clean up after the
 _require_test_fcntl_setlease() test
Message-ID: <20251205171422.u357tlxsc5ufl3ka@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-1-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-dir-deleg-v3-1-be55fbf2ad53@kernel.org>

On Wed, Dec 03, 2025 at 10:43:07AM -0500, Jeff Layton wrote:
> Remove setlease_testfile after validating whether a lease can be set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Thanks Jeff, this version is good to me. As this feature has been in mainline
linux, I'd like to merge this patchset in next fstests release to get this
coverage.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index a10ac17746a3ca4d9aca1d4ce434ccd6f39838b9..116216ca8aeb4e53f3e0d741cc99a050cb3a7462 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4656,6 +4656,7 @@ _require_test_fcntl_setlease()
>  	touch $TEST_DIR/setlease_testfile
>  	$here/src/locktest -t $TEST_DIR/setlease_testfile >/dev/null 2>&1
>  	local ret=$?
> +	rm -f $TEST_DIR/setlease_testfile
>  	[ $ret -eq 22 ] && _notrun "Require fcntl setlease support"
>  	[ "$FSTYP" == "nfs" -a $ret -eq 11 ] && \
>  		_notrun "NFS requires delegation before setlease"
> 
> -- 
> 2.52.0
> 


