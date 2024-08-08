Return-Path: <linux-fsdevel+bounces-25474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD34794C603
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE05A1C21EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051015920B;
	Thu,  8 Aug 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cEz1hUR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB91553B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150512; cv=none; b=Fyzv/aCmx/wMZNx9JETg+vIVrzWU4QRdQYC+RJMDuwKfo3Il9lMBxrrrfMocZY+2MDrGkGTiCjtq9SyX1CbDYL+lbuG6XlzuIKiBSMLFLbhSuM0PJTUrw31/Q9pcKPhbyTIG77qaBDG7kAlcGOc8phf0mTdgvswRHGUVbt3ZhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150512; c=relaxed/simple;
	bh=alL33QDUMO3Gtu8T02QKWb6GAI04j9PGhdR9ysqgNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih2pa6VnezCACC0UYeyW1dY8PTL6Grl3EqXCpXXfFDpw1Mu0k1bmYNiXaY2YHAP2u5XbYNJvBVi7DAkWmrISADTO6jSfzLFp8cYmN+Wxoo6+/MyZdCQCNE06jDJrwY3qftrOPzierGdNbMVIlTa0dE+A1SQjwriJx8S5SwLA6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cEz1hUR5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d3959ad5so124683385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723150510; x=1723755310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vfljrX8OmsTedNdC+viOpTYZfWEYyL9LY8J596dK+A=;
        b=cEz1hUR5kFRVOr105l/RNP9jFs+jMoa1jkJpan9cXSuj/mNOZJpsKQIJSj+SFTgWCI
         sdXQgwB2Ou7we0vC32Tl9YSyWkG4KaRzC9hCjVO6ftQBGGZOvIHrx3F8zlaSOhZwCp7F
         Pn4wDNm1Tlvp7OZKMBZAU5A+uR75WDaWWw44O+KS//e0VzlorMIhmbouWnDX2bjazq0e
         tJvvTqybsLpQj/vqRbYbs1wx+dzprgfnq6fdD1F1C7zhMikBt0ISuDdlZAenU92Q1koH
         w7fr238EG9GALDxiPyPJGJUdpPcgGnpcpOQHUpm7LfzwO4PsScC/zrjWSY7GI51LHy5X
         4Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150510; x=1723755310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vfljrX8OmsTedNdC+viOpTYZfWEYyL9LY8J596dK+A=;
        b=aGBmJhALHl8mmlWrvkvSTeOIvcqXKghIiNNVXmE6wX0zJrpIN5uUcuW7NVGZQeXhr+
         3j7CEMugKgDeYNzdhql47TuRnS8fTJ2qXXTuwinN1xECZBOEZLXgveLXjKEM13INoB/s
         GCuumGbHgO/5XsXOjZX8iAaSrhJS9xVubj2pMKdC3cbbwXraTnfcp3xYEXigPOgBeYbG
         V2WBjQjs3Ubwta7qIV3LyAxxgab2LG0IHtTfG4eSOxkjnw0re8dcbgqSB98g8AyqJJ0J
         LsPrX/D3tSOIJCuR8jGJohhFgRy8pOyLaFa24WGL2DsevcMMJ0hYtFDyvuW9nU53btXa
         9arw==
X-Forwarded-Encrypted: i=1; AJvYcCWOz2G5QxzLEK0XnCC8n050/emb04xTqmxABBRw9wGTJoX57pfiWzo+73QvxmCx0Afyk+gYhtjCz2+GSTuYMAR5gGx4MFEnXbLUYEgNhg==
X-Gm-Message-State: AOJu0YxpWDwgBwt8CHFtNphw3iCGLEcI+E8EDjGZlFc7VUHFdXb+Yl45
	uEYA1o2z5Bs83PH46ZjilBxf2ENx6mYjIPMq8b9aK7w9sYMT5dIG4vXDGh+Zxgc=
X-Google-Smtp-Source: AGHT+IGSVfRGUHjK+gji8OfdSpSNjQG5FHFefm5SGanJdS1BEqCoewLuJZ9fedevfAj2h75Keaw3Ew==
X-Received: by 2002:a05:620a:44c3:b0:7a1:e2d7:fc98 with SMTP id af79cd13be357-7a382476346mr641259985a.11.1723150509891;
        Thu, 08 Aug 2024 13:55:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f4301sm194991485a.69.2024.08.08.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:55:09 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:55:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: only read fops once in fops_get/put
Message-ID: <20240808205508.GC625513@perftesting>
References: <20240808155429.1080545-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808155429.1080545-1-mjguzik@gmail.com>

On Thu, Aug 08, 2024 at 05:54:28PM +0200, Mateusz Guzik wrote:
> The compiler emits 2 access in fops_get(), put is patched to maintain some
> consistency.
> 
> This makes do_dentry_open() go down from 1177 to 1154 bytes.
> 
> This popped up due to false-sharing where loads from inode->i_fop end up
> bouncing a cacheline on parallel open. While this is going to be fixed,
> the spurious load does not need to be there.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

