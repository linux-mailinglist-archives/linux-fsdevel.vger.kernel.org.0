Return-Path: <linux-fsdevel+bounces-58174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25846B2A951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1DD5867F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09F3375DF;
	Mon, 18 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWLoY4B4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8E308F02;
	Mon, 18 Aug 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525709; cv=none; b=jrOpoyMpFWvfK02DK8/WN6Q00KAxO4Ob7vXJ1ptRnqY1EnWEUbahvrjnCV/lFCZEOt3eMQF2xcq1VFYmjyOxL4WHB96999UZ72Zx/chuLmHi96kF1/416lg0EZfUboBtU3IWoGnD/KDVDJ+njMyZpOrmkrBSVd8BH+5i+5XKm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525709; c=relaxed/simple;
	bh=y2Nw6yRVcmnnk3DER/vCk4B9KctzAxdvSFV70vMgIxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoQqatGmn/Cwsb1OFWn7xy3OexBOFOdtFF5P5ckXes+Z+xRMirvAM6Vt4YhhdKOFd+R+jCOD+Nrv0inMh3tHtVwghi/d4weDf0Rt6mQtAjDb3G2z+qktLfVBO0c0AovQ22EH7DTzZqr02xLzAKhUWeKpM35Yoa694avpd8rn88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWLoY4B4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so24674575e9.1;
        Mon, 18 Aug 2025 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755525706; x=1756130506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7aSm/eI7kfLNdmsL2BItZGDfjAkMGxOsO5FNkHNx+Y=;
        b=CWLoY4B4P8KdBXyE9lrcLnL2QSpu7dwHtjHTbe7MyI5+ig1tm512UxXtXeghwHyIf4
         kGyzomKseczkKwcvckCwuq0fYwMoXrY5vQPBwB5DowHtcyKUWihwAM4MO8g+fclj+JNE
         cyCPMRzjfPLYSlTsLVT6E2/1CRC3lIM5RIRAhnd81DKM9JWcFpf+HJgO5/7J0BHNFOUd
         QJ0/wautwc1UiEh4JBtVx+8ZLn9YULBj2Ws8tNg7NaiWAmxPruVKa7McMnqLlCBUdstH
         QtzWuWc2c2NFWQvADg55kcthHVJpRqkaYRX/GS3hHPNLpTA1Irkp+oXMs3A8+Azopplz
         rTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525706; x=1756130506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7aSm/eI7kfLNdmsL2BItZGDfjAkMGxOsO5FNkHNx+Y=;
        b=p9+5UgQXB6MsKEKgyP3GH98FnteQHffM7YlioPEDMGTHPG1MGZlrMDVaOcLIGn17fG
         zxXR85ypkBH5MZaW9OCeMDA7Z0JqjTkyRVf5HyNDhjjirCe8QSuaAU/RQQLoC4LVQ7AK
         1AgknEofeHEFd+OUNouvV3b0rgVzMf71Zm7by2f0NBV2lDtj9goig30wbL6DfQeEX/vd
         05wTdKTuJYsncWFt47Zlmm0E9NPR8Bi5G/7MtjwYroIMtpSbOYA01zOSiCW7pXv6po3f
         l+3gmK1q0l8r9mn6qN7o6diomyy8EkPJghwqt0bz/sJm0May7gF5V41lKfAkZCaxB0wr
         Nn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Dihqtrco0uzFPF65ciEjH8ftihHUAAn6lHGkWRehQLvfntBwUCbB0szjRzi4eL5T257zXcoXD+mfaDLo@vger.kernel.org, AJvYcCWp83bf5Psb/iw+Oqf3qqQ+P0PKfaxeWwcPM62W8zjh7RiXrwRKL80weXZerurbBS6HBr5KFROs@vger.kernel.org, AJvYcCWwxu2iEuIfKXcu7RoDvR/1kPhfUGzEC53UVr+Tb7GSq9O+ZNJYWvSe64LtEN0Qr+XdWFrAf/HDnvAOrlqV@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKCFRIwEDYXsoaxgVE04ZKLShAY5K7hOaxLDfJO7DXzL0+LG9
	eLKOfYDtBH0nngqJGFFJld0EfIeJhiEI8ERXb0BCJ4hnJuELyBNHK5FH
X-Gm-Gg: ASbGncvZsLSag9YpKZiNSfJW7EtVkyliB95+GXsceJ8RpzYEggg4SiVg3UC5sM2jnHM
	4K1+HagWYgO7p3nqCWcNfRjxRVXcumcWHu8tuZpNLQAMPq2762Z2y+Q+0WMXg3ZWQLmKJiQc+By
	ybzHr+vTwuHiyfhcjEf0dl/lP5Do6VaT37Fci95aonoq4u+dXxwoMbYamriyxaAfEiiwdtZn+iq
	wdd8i8Ts/g6Ttxujs5R/mOoMKlIU7PLKlLegl5g5azVwBy+S6z2WW85sRpYyv6nCr32Nl/KfO6k
	azxKG9MFi6qMtyd3fCjqTbST1kRRJKR3SNRAyRTbLTgCY4EIPirsUTW6hfEDs4g2JViANtzD4Xj
	yOzJaThMvvAqI0OBsaxa0hwlIvv+QhUaK69it9Ss7/MsHy3LJf80fC0M=
X-Google-Smtp-Source: AGHT+IHo1jNpqNRhxvdXmyRhn4pc2gYVNGj28wCYI+06cBtWEKoBFRZ4/BiPgAXoKdGQaE5FzdBuhg==
X-Received: by 2002:a05:600c:190e:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-45a21859692mr91052485e9.18.1755525705541;
        Mon, 18 Aug 2025 07:01:45 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23323c56sm70600845e9.9.2025.08.18.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:01:44 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E4231BE2DE0; Mon, 18 Aug 2025 16:01:42 +0200 (CEST)
Date: Mon, 18 Aug 2025 16:01:42 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Benoit Panizzon <benoit.panizzon@imp.ch>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [bp@imp.ch: Bug#1111455: linux-image-6.12.41+deb13-amd64: kernel
 BUG at fs/netfs/read_collect.c:316 netfs: Can't donate prior to front]
Message-ID: <aKMyRpQig9j1M8gF@eldamar.lan>
References: <aKMdIgkSWw9koCPC@eldamar.lan>
 <20250818151814.18d5dcd4@go.imp.ch>
 <20250818152409.2d2db023@go.imp.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818152409.2d2db023@go.imp.ch>

Hi,

On Mon, Aug 18, 2025 at 03:24:09PM +0200, Benoit Panizzon wrote:
> Hi
> 
> May be related:
> https://security-tracker.debian.org/tracker/CVE-2025-21988

This *might* be a different issue. We had the metadata wrong in the
security-tracker in Debian.

The mentioned commit was specific to 6.13.y and 6.12.y and for 6.12.y
it landed already in v6.12.20 as 62b9ad7e52d4 ("fs/netfs/read_collect:
add to next->prev_donated"). 

Regards,
Salvatore

