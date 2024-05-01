Return-Path: <linux-fsdevel+bounces-18437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C88B8E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31DB1C21AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2556DF51;
	Wed,  1 May 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY5cInoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01B8F58;
	Wed,  1 May 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581656; cv=none; b=SRbOHpct1bctrSIRiIeCw6AVsjoDcnv+gUvflqHYe7iO1wfK5ZSa+O2GjOv3yA2GHC+6mDpH7GSKLal4zpzjEtMH6b9SJWjxfhLW1lge/KZJ9UxEOWWQ3GbGKTo23bLFZoAvddABU5gQzt0HC91oo9n91scwJyDNMuK7zwvJt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581656; c=relaxed/simple;
	bh=nR1Qm4DJN7uo5wNpi2m2Z/EIIU2ePczqF64Cv0AT5Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdwrSLE/oaaexIVnEOfwVFQTYiaYaECV79siAHXoLtA/v/5HbbEZfP5f8QlIdlHcex5i5n5KZISKYAYBzMnUkeGYzttUE+0txEcmhJXbYZ4Ao9ST2cGCQ2Cf6u/jyAkA0qAYGu68z6dLq4f9Iqfl5JWZkr1oJV1U0b9wKkQC1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY5cInoV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4919125a12.3;
        Wed, 01 May 2024 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714581654; x=1715186454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUMDq886brWG/iK3lObFVRTNP/KpgYi0SpmrG9l3pfU=;
        b=kY5cInoVr/o1SE8z3GrZMe6q3YeB3ElZAKBGKltuDaTSpV7DqvzVgsagK7gXfc+Ynu
         VsaKyIJ5m8BS6Bw0PF+h5kMmZMPw7JDXG88etVG++JFMzsZwVgnzecawYeKsvBujBezR
         jnMhK+zMwgFFGHsE9id066qhEtgsjAc13ULmLuP56Xhnp9if072OyuyhixIPyYQ0kXuy
         4dVof1Yq1do9z+tZPlUBeWOTL7ImSzKRdoXgtsQQNQVG/r/MkVWA3uqGrPGo+7SpkLh5
         d9Do0giag8+EMILUHLVizfa94efhK9yH6Bo9++o41gHbtRBNFbXmmFyWGfpD/tzwiNYs
         JGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714581654; x=1715186454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUMDq886brWG/iK3lObFVRTNP/KpgYi0SpmrG9l3pfU=;
        b=fidBIvaohSRXqVJ7+PUF16smbkdWCEaxNvmz4DkonUe5qrSnxE/0zyFsDhXx69hskx
         nXWDvixxyBbtsfo2LdMnI0hGpDLHa8fHhZp9+/OQclDDfZ+XthXSuoGCj8g6qtdfp87O
         CYEKTB5Sktg9wfgDWdHDoXTKfyRFCAWhrn6uMW/BefAOHFfM3ZZ/XtC1E4lBx3Gj6gWc
         zZrK9kYke9kWqed7wTLNmQ0c64eUyDrAc3rrZJ/B1uE7Q/mLpv3EE1/GWEr4EU/Q3GAe
         0g3PqsGC/RtLqxlSv1EBCDk55i2uLN3NNa9a8ZVBsKr7pj0jAWS9mOsxjFzn9PDBq5+3
         DUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4extWtoEDF5/N1D5OYaj5wNRY9BZqN+bdKLYyJ+XWvytPIYku6fg2unianzKz9ZWQcZX7GxzYK5c01LzEC5c85JQcxmBk2RkEwLGRPqVS5K3/IMj0zp4bqnhcQhjUJtaFWfTUdqZeXtOgQ==
X-Gm-Message-State: AOJu0YyYWPeaHwhrSz/pTrzeeDv1UQJxg5QlNl/GkeUbsRzLRfVTHJS3
	vNloyJvukhVUUlKW1J1ZZJ8+hxr30wTJPhBS7NgeCwrCNcohiKwE
X-Google-Smtp-Source: AGHT+IGORi83PoZPdA3rN9Nzl0hVavuekUtxyDHDG+F20qP/0jKwaPzyRimTL9apcEdpyCq6kmUnFA==
X-Received: by 2002:a17:90a:1fca:b0:2b0:7f15:9155 with SMTP id z10-20020a17090a1fca00b002b07f159155mr3004322pjz.31.1714581654409;
        Wed, 01 May 2024 09:40:54 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id sx11-20020a17090b2ccb00b002b1750f228csm1546999pjb.7.2024.05.01.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:40:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:40:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] writeback: factor out wb_bg_dirty_limits to remove
 repeated code
Message-ID: <ZjJwlKzSYYR1hx7M@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-2-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:29AM +0800, Kemeng Shi wrote:
> Similar to wb_dirty_limits which calculates dirty and thresh of wb,
> wb_bg_dirty_limits calculates background dirty and background thresh of
> wb. With wb_bg_dirty_limits, we could remove repeated code in
> wb_over_bg_thresh.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

