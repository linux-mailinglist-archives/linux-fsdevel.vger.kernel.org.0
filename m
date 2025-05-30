Return-Path: <linux-fsdevel+bounces-50210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A12AC8C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0279A226CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E452222C0;
	Fri, 30 May 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9oWNYnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281178F59
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600629; cv=none; b=RGXmEwWm31FO89OTWsLqx7af2qdSGSVT8iY8Zg4NKoBhU6VUIEu3PQbnzLasXj/42CZLmF2eIVNxk5k4yDQhiWBnCjVS5sllWd9g0Xmetkb0a7TWv5jefhiSx8GAw43LLIKhxvrWd+5jEkVa0Ajnxx9XYDIPMJcEkZDD4RKqAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600629; c=relaxed/simple;
	bh=zgT/MjgMpDPsaHt3E56bqSXE2OuI+8D3G3bl84uv0Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6+Xn7y4w5I4gvInLSi5pkxSkfhXY7Fr2LvwuOZH1mc8X/UfocgjONoDZ7ZVN79VPDYYRW/wjKyJ+0f2j2h1dNgCy0iQZJgN5iHt/vjZftX+e4dVe2yR6iahUi2JndUEqtGFHKEzU27dlcyBfS+VQxUYx/nl+3II/EFcENywKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9oWNYnd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so22566635e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748600626; x=1749205426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8KNR9OGSZRtTkE7BYOybOhLSnaQfO55gQ1kPbK5Ff4=;
        b=b9oWNYnd18yffwXfH+8dLq1AnvFtE2DPTMHoAej74IZcf1WgzcRcoL440iFvdayfiJ
         O2DgWsw+NfiHp3vx/jt4FqU3HtjiHOZjUBcD1MFTkXSm+GzxQFUDp4fvq2dER+7dpQBs
         5fkiStlH5pluiKFPHn2xDdlP6qdvwqSvx8TS6QLwwWV0ZaIG7Eph4EKMrVFTjVSgoFMs
         LAmPlz7zevkjK7wvxbrZVD4etVmBIzIBPmlEXmBs6YYVA+eD3RYBET/ku0E0xCzUJ+0h
         NPBdjxhEWDwxEAvje/HoQOe6EcLythIVM3XG7JsCo8z133QkpUS3ju2X1jJUz3KP7jYO
         7Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748600626; x=1749205426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8KNR9OGSZRtTkE7BYOybOhLSnaQfO55gQ1kPbK5Ff4=;
        b=Z10YrHUaRxQgF8cQBCXbDLWqERVDvnt1ZLhB2uknD25qJ458KA4IkT6+Lsz8gY5ZUk
         aiQO5WGWmoDrQWXvm7ltOMj4H/X9OAiX3JmPYF662a0TYnUCbGftsc09MMtyTUeJL5SB
         skOVWhmeE3xk9t3aKy8KNP2Hp1+7kSMMBS9GTDHtDgrflZVczu9uLYS4IwOzlZy1dkoj
         8uWjiuX0XVsVlBFkjSU5KpGCmCoQtzTwmanBt2XrKTfqohud28Qkunzi4pWmfg319fez
         ozotqf4Kb3XQH2SeMbzczg7J+21Ga7V0QzjXY4gBpLj4ca9Y71KTtupfT3Gvt4Wd62zx
         EFNg==
X-Forwarded-Encrypted: i=1; AJvYcCU+86DivGOsBpPTFs+03FCWhKsC0Chbg7k6+RQPZfJHQ7cOzUGKm7OQG8+hudAxJeCsbHhbVljvTJYe2kfj@vger.kernel.org
X-Gm-Message-State: AOJu0YyebPmVBstmPl2nR1/hGBZdT3yB3+B/5LpJIkyApG8pBIAkTv8w
	paI2M3F/jOLq1KlV+dyTfedOgocN7EpexCPcbvmw5fDUdNkDc+NQCvJASOCIyE0Dtiw=
X-Gm-Gg: ASbGnctG9WDvy/nzGf3n03dJCXN+DTVnHZ+DNx8QEYbtyqZRZYtNMRS3088VqV/kkWL
	iZ7c2l4tAVe106SkusZJYGkLb2XLhtn/fiEuDElK7v/SVkydtNbhX6vdyHPru24F/a4oNsJcf9F
	s5dUSBmgRctQUFivpAduYPDVW/urk3JKylpilkVuT77XFf5rYSlCoLnyvWzzIdXlYfTIBrvCvc0
	J+La/XkZCxBUMdG/2ELJzaTPQ9F29xy1MJQkaH1e/ql5RVh6FuG6+9r2QBHnI8C3oxXWYubkgOM
	k8LLQ7TFYn8CoQI3w67vYPhpDO4JZGDmZBa1o2F5SRJOEv/3TvXBgqNxdRs+z7DR
X-Google-Smtp-Source: AGHT+IFuFzDUmylAHAIt6CmGydI0iWc1wwvnaWi7Nzf5dxp4QYaKY7sas81SAre3IsvZR01wrooFSg==
X-Received: by 2002:a05:600c:608a:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-450d8868f88mr14079325e9.25.1748600626052;
        Fri, 30 May 2025 03:23:46 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d800658csm13986585e9.27.2025.05.30.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:23:45 -0700 (PDT)
Date: Fri, 30 May 2025 12:23:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	david@redhat.com, shakeelb@google.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: fix the inaccurate memory statistics issue for
 users
Message-ID: <aDmHMLpMBTPCdRBN@tiehlicka>
References: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
 <ea0963e4b497efb46c2c8e62a30463747cd25bf9.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0963e4b497efb46c2c8e62a30463747cd25bf9.camel@linux.ibm.com>

On Fri 23-05-25 15:44:37, Aboorva Devarajan wrote:
> While this change may introduce some lock contention, it only affects
> the task_mem function which is invoked only when reading
> /proc/[pid]/status. Since this is not on a performance critical path,
> it will be good to have this change in order to get accurate memory
> stats.

This particular function might not be performance critical but you are
exposing a lock contention to the userspace that could be abused and
cause contention controlled by unprivileged user. I do not think we want
that without any control. Or is the pcp lock not really affecting any
actual kernel code path?

So while precision is nice it should be weight against potential side
effects. 
-- 
Michal Hocko
SUSE Labs

