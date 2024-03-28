Return-Path: <linux-fsdevel+bounces-15604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C4890946
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F801C28A53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD11386B2;
	Thu, 28 Mar 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMt6Crun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206E1384A1;
	Thu, 28 Mar 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654320; cv=none; b=g9CrxPW4Wn1FEyrRvl4g8YC7YkVNxa7FxFjBbYreMpTqgffwj2OAqF2289YMNLvZ62+bZ1A98c5G/GamgvubdvXuvlQGZxvvKUE34JpRyN7hra1wU2GXINxQffEtMD5sXPdp3W9lRSoMSMsTaPykP3tBHa48sUg4Yel/n0qZ16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654320; c=relaxed/simple;
	bh=ioVBxNL6RiYBXwxZCjg5XLQJjsF/UPRoMAqrBWo6zwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdWJuYoIfevtJ/uyzgB2xGzrR7G6Pah8mXr9ynX+TtbVj+lfn3frUJejdP/iqiUGN5RkdR2+hu7CVEw/k0BMb3P1Zc3p7KYH70Lev790H1kTf+h2bmlJQ8t/bLKME9iuAAcrSbQa58xB6FCt0Ar2qUJMTHJ0FhaVT/MduzeQFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMt6Crun; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1def2a1aafaso10412015ad.3;
        Thu, 28 Mar 2024 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654319; x=1712259119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhfbUSiwIuT8LIHU0+RkNyojAQTzCsx1VSv7AHZemnA=;
        b=aMt6CrunNF7J86g+EklPw4f4E1LqKYAs6pGxWI54QIt9MeHTak4hCeMKwjNPLvFPhz
         8WQ5rWyGvBW/1sahvQ+tC56YBSPfVkmAQosYmzH+CNoPZC1UEbADg23OZlHFcqleww/P
         PVB1v+k8NZ79tpjen8zp/69UghIW80B4TW32wZOi5XlZL9BawrCtiAWV5pun1u3QH9SQ
         vzyrjeLStcbFj9vVRW6rJ/3BrzVaFZtM/Z5YdF7CdYFZcsMC2EGcPrRMkpLKinV2FQer
         cKh3zy4MksGLFd/wT44rsco4EnDTwvRDoHuko1d7ci3j0Ucw9CV8LiS//KqCCcPH2Dig
         ULTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654319; x=1712259119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhfbUSiwIuT8LIHU0+RkNyojAQTzCsx1VSv7AHZemnA=;
        b=AGP0kxZJ1gvzgYgkUO93tmsKFg2fUtwG5vvlPFXZjchSj9uZDSKjJ/cAJze8Gr1wvH
         z1xoS4v+F4miCdsj2c0Mw5UCXKfJlMszxZTamla+8nVL1KJwIVE0WhvLkqsiWjMFtJyG
         dETo/0XbL7Et+3vAC8dypF1/8hUo9xtVEcfBtUCH7W0IQHwO0TETrosuCtAJBiiaqLnX
         e0S0qs8rM6hBWJ4nW8YkMYeW1NaXUFBlUwq1WqS6BHwpK94dG11KPUyRrTGwupE1OyMB
         duFByuLd7fGHlD3lpRLLvmzXO5TA2Qma+wEq9gJ402mugHhW8yeBg0eXggxiJyPJZmXC
         vTJA==
X-Forwarded-Encrypted: i=1; AJvYcCUD6EeilGA8bKqvpbeStc6CdPCjB6KrfN1AEmZjoWCoCNhrcm6B4EF3NrBu4S+FfBbcb2/dugm+hFtNEC/h5n5IDJnzUFqTAPO+eQmtMuBbR/sx/hHpWVlDTWOSWabBUN61wmWinlVH3YbEfw==
X-Gm-Message-State: AOJu0YzCM1Lk/uYUU1I3cvxdBRk0TENfKxQHJOt+ebY9jr0T+2LQjREU
	o8waNH/i7tF0MB6DOkna8EwSy+ADblbL2K7Kv06bFq806uivm0H/
X-Google-Smtp-Source: AGHT+IG2EeIzMXCjgNUYqx+aDJKclqaKpMMWrn0g/2Imx4HnSHvQRyRUTiSJPCS3IUxr/GDAtLt6gQ==
X-Received: by 2002:a17:902:f54e:b0:1e0:a2cf:62f2 with SMTP id h14-20020a170902f54e00b001e0a2cf62f2mr491565plf.23.1711654318736;
        Thu, 28 Mar 2024 12:31:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001e0d88c908bsm1989805plr.281.2024.03.28.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:31:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 09:31:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <ZgXFrabAqunDctVp@slm.duckdns.org>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>

Hello, Kent.

On Thu, Mar 28, 2024 at 03:24:35PM -0400, Kent Overstreet wrote:
> fs/bcachefs/time_stats.c has some code that's going to be moving out to
> lib/ at some point, after I switch it to MAD; if you could hook that up
> as well to a few points we could see at a glance if there are stalls
> happening in the writeback path.

Using BPF (whether through bcc or bpftrace) is likely a better approach for
this sort of detailed instrumentation. Fixed debug information is useful and
it's also a common occurrence that they don't quite reveal the full picture
of what one's trying to understand and one needs to dig a bit deeper, wider,
aggregate data in a different way, or whatever.

So, rather than adding more fixed infrastructure, I'd suggest adding places
which can easily be instrumented using the existing tools (they are really
great once you get used to them) whether that's tracepoints or just
strategically placed noinline functions.

Thanks.

-- 
tejun

