Return-Path: <linux-fsdevel+bounces-9094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3E83E196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082042827C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73B200D9;
	Fri, 26 Jan 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cz9CQuHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BE1B954
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293932; cv=none; b=DeYcerOjgUZRlREMdWsCUCNyuAQoyZp0/5ZCuYqYD3Nvn7uPW/QUYMo1QblrtteT5B50g/qOeKR+/J2328rR2uz7PckigYqvdi6kkMva40YzkWKCmIXbELJScD3vetDqOZSok3xVbLGZRLqs3SGPlXyXvvr84Tv+Kt4GPgZIjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293932; c=relaxed/simple;
	bh=npphpisri3XPKAbtB0a0IVCBAoWiXMc97DCOBdOZfzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD7vD/qbjAg6ja/p7gTeuJaxMwGdAoqE2V5rN2LXkBjwzZWi9KhZdcTOgGkhft8bREp4D8KLVKiTaCbS5ogCZz9KdqW1b3dlziwT6RT5dFYBUAciAecKDObLZQSNGyxtqM5ebmBbk3iTjYS8Xe2LphCf3thkCITaZHcf5Xpos2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cz9CQuHo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso409290b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706293930; x=1706898730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdX+qj0yNqnHj9tuX5qSNRIW39sn49NKdS7uftFX8bg=;
        b=cz9CQuHoGDLBfAcMdTVQ6H43lb6pl4SQDF6X1RPSneXa8WSmIsEKHyGZsDAiXgDkRM
         Mgr3l7nGjLYGyyoLa2fKQEdBD1r3gSGTvE9ohbfL3nfuI468riT+6WFFPXLBouz76oa0
         pgTxxMvMsUeWgUukUu09M6u4PWsVra6pcoxqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293930; x=1706898730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdX+qj0yNqnHj9tuX5qSNRIW39sn49NKdS7uftFX8bg=;
        b=fx+tW5QpHVzmqOUE4ZIIlStvN/ZmuyS5zVrEEJ+0n+i6jtOjvpfzYozRp4CAg8RW1i
         RfqqPR4lb/gyYlqnee9kxvcDLAYRQwawcmEgQqRkti8XOwFzo+BK7IZwx8zB6lzSNmst
         H/SLj4OD7qYZC8JoeAF71FCDMtiFJdMPse8g3jLVSPqLzrCteehTZdJa6ovZd+WMUmg1
         eOrVF17ffeoZLwmQQA93Y5DEAdIFr2XhH+YF0yh/zWubbO6+812yOeqp+iMSTZrUcuKD
         5JjoWb4HdJYan9EpY62tp5pIB+S8xhN+8YljVzqeFlHOJGwbdzyGx2weC6GavoDBFfZu
         aJtQ==
X-Gm-Message-State: AOJu0Yy7cYMLaF6MY6ANW4kUlg6Bf5hRbIk4eo98Ma17Qb65P8tyLbUd
	wF743RUFrp+w+7oW1OxXtcSQycx8wox9eBUsYe+AFZifdl32qPghOyx0QpCbFg==
X-Google-Smtp-Source: AGHT+IHMQ8+WfnqXmO8t95sK/Rlm2mUekflUv4KpnP6ah1WQJ/+BLzZNOFgmY70/He3L42StAR2hFg==
X-Received: by 2002:a05:6a00:1d1e:b0:6d9:e97d:c68a with SMTP id a30-20020a056a001d1e00b006d9e97dc68amr307550pfx.23.1706293930539;
        Fri, 26 Jan 2024 10:32:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78453000000b006ddc1ae04eesm1392548pfn.192.2024.01.26.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:32:10 -0800 (PST)
Date: Fri, 26 Jan 2024 10:32:09 -0800
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update sysctl tree location
Message-ID: <202401261032.F8C0375E2@keescook>
References: <20240126-for-6-8-v1-1-9695cdd9f8ef@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-for-6-8-v1-1-9695cdd9f8ef@samsung.com>

On Fri, Jan 26, 2024 at 12:53:10PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> To more efficiently co-maintain the sysctl subsystem a shared repository
> has been created at https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git
> and the sysctl-next branch that Luis Chamberlain (mcgrof@kernel.org) maintained at
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> has moved to the shared sysctl-next branch located at
> https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next.
> This commit changes the sysctl tree in MAINTAINERS to reflect this change.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

