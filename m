Return-Path: <linux-fsdevel+bounces-45311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBCA75E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 05:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5377A325C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 03:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AB13C9D4;
	Mon, 31 Mar 2025 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7q+hAYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B320E6;
	Mon, 31 Mar 2025 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743393137; cv=none; b=Mq/ciDnTrrhFjVX5Aff0nXNRnmS+r+ZOAP9A/pURfpsC7JkbUsOjHjle17+j03j4KEwNt7aC9QjXVGqoAee1WaPpVZaquaNp6+VEKZn1zQGTWip5dIZP77oaCPLnnJAAsZmUGyy1U2lGcGH0hdE5NM2rqoWfxqluUnvtX38VGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743393137; c=relaxed/simple;
	bh=prYBJ7EyvpaFZ3S/55s3P21HVzdoeTTd1doe67JZr4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irud2u3hqatO1JH+0SNBH3nFDlbawRAlmjZMq1+CMuRgU/HiPpLlAzAMnH619aIi4aqqYnjWoLUc+ZWZZ6zLeduLa/5X50I39gLJawMQ4Ng8xFuVO2K58DvxAmLmqUAt3qFHOJ3BHc7UKoHMivCVaPBkxzEE9//ZTXo7RZxe6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7q+hAYM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54998f865b8so3993140e87.3;
        Sun, 30 Mar 2025 20:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743393133; x=1743997933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGYkbNNYPJvEF/4iUZAE4nsCYBUBEw8w1lknk92z4UQ=;
        b=C7q+hAYMklw0Pi9hBb9Cyyv0QD7H/MtKt+XwE9mxK66w7gIVYlKrkfxRuQku5LTsPM
         yT4rXYm/b5c7RHDM+YVL5UprMCNybHLR3EyjxuPghdFYHKOFgRaVwaWvj/ZwVdornsbt
         BIbaFUIpo/p+ohSLY7I7PcnMKV24tpClatDza7H6maJ7hqa6/zkA5EH4Yr+0gSNu4zsW
         E8V3nF0T9gNtjIdHTvdPWHJHJMkcwMhf9bEn7LpwofTdUbXIMKfxtQQqkJTTCwm5y7xb
         2qts1DNjYCQcetTWzmF1zq6Y25f7muX/+/P0dI890QHFAycRvf6ciVn/Fd2UIwXmMhsE
         KNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743393133; x=1743997933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGYkbNNYPJvEF/4iUZAE4nsCYBUBEw8w1lknk92z4UQ=;
        b=vHoOd4Q58u1rg/1Udrm4rZS7ALCjbBlDCAbTycdzq0C0YIauD1ysZJNCTUdf16ghXC
         dwBNHM6Bfu/z4Kj3f7AH3HGI//inPqjQ7odonj2PIN4fwhskoXA5K4w7xFpY2dA9h8ib
         s3h5MHZrXfixpK+mh5aXDfCy/Hricoj6umMwrx7Tlx3dmr/MDhBxxdtC2yFsTT5lpRC5
         OEsdlrevA7M+ayuxOdVQ3FJfhA9xYaNRwGmtO9+PCJApDp5DKl+tgzH5iux6qRqKlmmB
         srXIZwUyYp0KNXaDONHrWEu5cAIafJR/sv/VY7Wi5nm0cZMoxWYKMB7EI4II37jxpyO+
         qZzg==
X-Forwarded-Encrypted: i=1; AJvYcCUlX6rl/YKXDDrBX0bqSSrioua06kqU2+U+6TY5jNGZpo+bXV/3gPk63XeEf21cgVa5ehYc3iuuRqg04+kc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Qs6hFwgzqqnCm96N8/Tsglnmh50li/Q5YkzEnkGSneA+Hf7o
	ub6Y4eKF/q9fFd2pHcrt4nsU5bjDjBQGU9tLE3juuMVOXyhG72A87tDsJuza
X-Gm-Gg: ASbGncvonPQH2FqY0O/4hIQsgbSyHhhgPpJRXyWttKB0KCEQL4Wr1WwL7+i1ZnCCEcs
	I2C6rSDDJCNV61afN6XdrYvcwajXl2NcJSpq9Xr1wJyAytve1t8Z5dgSToyfDuJn4etuSrFuuxg
	VhqutFObSuOk6vvOvkTUZAV26MNidY2FZZtck8X9hqutmFWkWILExe9eegEjrm37AX6ycsSpBhB
	i67Eww5J04/EuFW7Y+oRkxWYcPuPyEWXO/o2xoBo8UKcwr7u3AdWeGm/E7TMhi3cQ4gwi02EQ83
	CyXoJzURly8g92oATbhm
X-Google-Smtp-Source: AGHT+IHyUCjFJC7vE+0HBnoaPNa58HytIUzs9oqFAGvA0djiPOaWypb/clSX02GDWJQguNsMueDlKA==
X-Received: by 2002:a05:6512:3b95:b0:545:3dd:aa69 with SMTP id 2adb3069b0e04-54b1112810amr2484075e87.36.1743393133090;
        Sun, 30 Mar 2025 20:52:13 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094c1b09sm1015766e87.96.2025.03.30.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 20:52:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date: Mon, 31 Mar 2025 05:52:11 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: ANNOUNCE: nfs-utils-2.8.3 released.
Message-ID: <Z-oRa3cF97JCGkVo@lorien.valinor.li>
References: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>

Hi Steve,

On Sun, Mar 30, 2025 at 03:37:33PM -0400, Steve Dickson wrote:
> Hello,
> 
> The release has a number changes in time for
> the upcoming Spring Bakeathon (May 12-16):
> 
>     * A number of man pages updates
>     * Bug fixes for nfscld and gssd
>     * New argument to nfsdctl as well as some bug fixes
>     * Bug fixes to mountstats and nfsiostat
>     * Updates to rpcctl
> 
> As well as miscellaneous other bug fixes see
> the Changelog for details.
> 
> The tarballs can be found in
>   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/
> or
>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.3
> 
> The change log is in
>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/2.8.3-Changelog
> or
>  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.3-Changelog
> 
> 
> The git tree is at:
>    git://linux-nfs.org/~steved/nfs-utils
> 
> Please send comments/bugs to linux-nfs@vger.kernel.org

Thansk for this new release!

Noticed that the nfs-utils-2-8-3 and release commit is not yet in
https://git.linux-nfs.org/?p=steved/nfs-utils.git . Could you push
those as well?

Regards,
Salvatore

