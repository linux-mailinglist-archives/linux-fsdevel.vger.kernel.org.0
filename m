Return-Path: <linux-fsdevel+bounces-29306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA0977E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9ED71C21E96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D31D7E54;
	Fri, 13 Sep 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G6g0Oh3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5A1D7E22
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227146; cv=none; b=f3uocLKq52GAX9ZXnpBU5l4wcvusCrW5dULM63sQJMUddNZdk1z5crnoglSHlwp1Q03tXy1DsIk56FG4TZUFBl2RLcJ+73OJCrKnC+akNqI0elyiqXplU5kEqqIjSCjeTjRf+KBLCRUciGhuizHjtiY2iLBW4FC0QEOLDIXC6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227146; c=relaxed/simple;
	bh=5v4NdqbYPDiRqhfNWq3dTnXzPLJsQvlk6g+gl0hStGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjp72UXR3XWr+sMCGx1dB9hd0dQHv6Uy/n8rI27cyfYH6sKgHKhVE2IWteEgVw1Fvi8by4wi/zVqJToJnBy36oW0B6gBYHWa7yWqnIY2OAmObjD0O1J0Qe2Hm9Z+eaBApoDrAuz2DKzIA6wHqh7tvVYGbE8rkodastTACPlk5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G6g0Oh3s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c4136f7f1fso2235639a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726227142; x=1726831942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XvQ+WPCgnw5TpCVTyzWv4NUFhv6UE6SYFp22sYw7Dw=;
        b=G6g0Oh3sKOOyDgcml47ep+d7Wfupj3bJwl1LN2PCkQbTaBHTboxRsxWHql3264n1k1
         zkaLes/BUnvQjnjjdxno0mDBeidG8VZ36Vg/07RmzphVIhzMfBVtKT5E6qs0jK/nhzeH
         4ZELunmkv2FaRa+DW/nxHeuhnD1tnZYRXS9kTGa57uO4o89vKFk5/2JKYMrNauhFNQzI
         PpeWJkuhv4Q2DCMpAR2KeTPfeo3SLWt5UE3erwh3tQPxd+1IvxhdMQ/iNz9wXBYfV+mm
         ePzg6mfv1eFKQqbBDfuy9k9ywuaTNhZqKKp8mXk6J1E44xfbp9N+Kcqsa01fUIjtunl2
         JeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227142; x=1726831942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XvQ+WPCgnw5TpCVTyzWv4NUFhv6UE6SYFp22sYw7Dw=;
        b=rg9qoSGYXMjFDOML7+Lp82/ojao5Cw/lp2fg5ouDmhuKRuMiBdtChttEDqwCHy1Ov9
         IWwkjPshMK/O6MQ3Npz4siguIuFGqxMNVEy/723PnG0rsqsO3U8smfgw6LV2tzPukcLj
         e5B90vRYM4SS9ikGVLMZ503qEvbA4s1k68g6uXT2JRtuZEv8i/Orict5y/JKtzQ0KJrL
         n28fqqU9cjltYnlDJ/R3IglB3/geD7+sZuK+3EJoFP1vdOUHAVt0fcAlNsWplFacQJh6
         DCPYRMK/YJZZxcJ1dRQJ9Oz+81Vgrow65fruVoyBkTOdjJwZ5fCPpC8jo3A6NdiZebxN
         lsWg==
X-Forwarded-Encrypted: i=1; AJvYcCWmEkkfGujHzvKO2HAcXvplDWt4b36aUc1z2cuXiEKYBe5lXy57HPvXX4NyPLv2/aTWlxdmM2zqL4gaL6Qb@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGXbhYpx8+/fa2Dy5GnvrQmmUWz4ya/R5449ccKz4qIALBXzd
	sBBXcuSM0xJkzEr8EUy74etSN54q8vCGK93/c0Pe/bXSh9IdhiHldlWNeeV7/Ag=
X-Google-Smtp-Source: AGHT+IFk2He77TP2kioeSwXBmwlMwi0GakIdhMDY2pNCObI2N0QZNysVa9OynBPm0mzSWIm+r0ei1g==
X-Received: by 2002:a05:6402:234e:b0:5c0:a8d0:8782 with SMTP id 4fb4d7f45d1cf-5c413e4c56fmr4214176a12.28.1726227142107;
        Fri, 13 Sep 2024 04:32:22 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd424dasm7600339a12.9.2024.09.13.04.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:32:21 -0700 (PDT)
Date: Fri, 13 Sep 2024 13:32:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jan Kara <jack@suse.cz>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs/inode: Modify mismatched function name
Message-ID: <ZuQixMvfcoI1Kg0-@tiehlicka>
References: <20240913011004.128859-1-jiapeng.chong@linux.alibaba.com>
 <20240913102935.maz3vf42jkmcvfcn@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913102935.maz3vf42jkmcvfcn@quack3>

On Fri 13-09-24 12:29:35, Jan Kara wrote:
> On Fri 13-09-24 09:10:04, Jiapeng Chong wrote:
> > No functional modification involved.
> > 
> > fs/inode.c:242: warning: expecting prototype for inode_init_always(). Prototype was for inode_init_always_gfp() instead.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10845
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> I think this is a fallout from Michal's patch [1] which will be respinned
> anyway AFAIU. Michal, can you please fixup the kernel doc when sending new
> version of the patch? Thanks!

Yes, I will. Thanks for heads up.

-- 
Michal Hocko
SUSE Labs

