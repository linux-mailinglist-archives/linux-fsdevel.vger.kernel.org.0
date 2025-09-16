Return-Path: <linux-fsdevel+bounces-61831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28920B5A421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1A91C02B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7222F9D8E;
	Tue, 16 Sep 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="dPWRx+0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F03288AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059142; cv=none; b=aZCpHXg/RDmXwJeWoCu59PVOfUYBvncq8yWZ2672v83u4diI6lEO1wS3UQItbwVCN/HRrPda17gxE1Lqn6h6GUQDZ21N1A5tC2JERHK9DKYNnXyU+qdM6eDZL9osaWi0t7ZB9G37VsW6O25cEWKBXsJK1eI7sgmoL4uIxTtWoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059142; c=relaxed/simple;
	bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDzOPj34mWFPHO2TXW93ZELwUryo0vHVP7C3wulcfTCqQIjW1fIoH7r9Ia7MEGxgkq5ZCa5UxSXAx/ihw8/WnKK0sDSIb1KQtnnX/nResyyGkh1QQfFJKXgV1YgjR5BHbLbkKkRxwIrJDoEmmWxo1cRpXD3LEF6Mc3ELi4NNxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=dPWRx+0l; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54acc8c96eso4219474a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758059139; x=1758663939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
        b=dPWRx+0lJ63wnaT0oGGWF9dQpCl2vFIQ9fgLeR0YNaN12g9JM5xAw9bR+HKVt/LHuv
         b0ni1E1OHJ+q1/DDwHMPsjdn/X4x3BPhQRHaurDsARgEs806xs/sgdc2BjRjHnNZaT67
         jOaYyZeTkUq9mZP4fOkxLpsJXdhRsZDwTJo9a6JTcwlS6v4AdZTJV16+DnlbbqFIlr2h
         5k2XuKwCgrXaXyApbbXxLlAGz0Jze3PV8IMCarms4l7lnJ517MjCQ//C4Pyd9ytVq4Cf
         nmsdu5cBl+MQjoyOoQLHMZ4GujY7K0gQn6SW0UvVwK1R8IyzpxyH/TfNa1De3ApG6c8S
         eqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059139; x=1758663939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oMu80/8qr3zTmEJZAl1KXHqB5S4PD4PrukmUZoG8ms=;
        b=O6WO9VzvZxjs2Rj4kDCgBby1XjBxkmeLm7IjE2Q7EySMQ+bQxroQqKuGZ2sh36o/Zq
         v3mtTsPpOqpeIdm6wQcS08xs6Egxs6HTSU9brIvH5TYo2yc/pLLMypfpZNpJ535C4p46
         3HUW1gburzG4l+fb7ELOPN/7Ug70IwegoGTkP4zEcsoIOtf/THTMW+NPmofeVYXbrAZV
         fqZerH2TUCZ8uzZkwAIjtcSliatQG83inHEvnnKrj/jc+Vmd27h9IMDvmuJy+KGn/vNh
         HRCDyX2j9D9tioKMP3vVsQELSKyoWAjrk0iasUl+zGxvO8iF3bnxVPTWKdPnsb7J91+s
         nWrg==
X-Forwarded-Encrypted: i=1; AJvYcCXXMLRpdtDkE2EvNtvwGu2vQe3nRgOBNJ9npIC+dkm49DCmn7z5aNYdZLD6zuwyROTarfMVad1fodF/7oQt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tpAfOjFPBmh3pcIBBf9V9UFBFpN9mOfJLJeFdS4hujZbNkEe
	4tHjrRlVw7doghXeCUYJXJaVUAuG6eWyvwPsMVFImHZNf7cNVnS5LaRX4nuq9TgzTYU=
X-Gm-Gg: ASbGncvItABliPUs/F6g2GST/SKHF7aKYRaNjYz3NmXDNwthl6z6PeRmPnaceRLKEV9
	oxtqAMB4149qWsm7Dp5iZYt+BwDYHy+zVZwLX2hnOH3LHKdK9TiYGdvhPR21xNbh/KRTdPP+XH9
	o24udmUigdsH0PF8N/0hkCGoA7MiiJsGunoxcY+vA0T4A/o09GJo0OOgXXncD6zUwfwmK8xCmZa
	J1H9sTCv8LZ1DybXQSQdcjTsvzhEWdH6J1KxZ6m0zrDqcwtKzbHzK2o4rZg1viAWcCaXmxRmDUU
	ByKg13Wh1AVlvhr2m0orMWDFqtwtWbEVpEXzrrx41rwMTYejoltc2P6So4l/ri6ivCzlukr+qzi
	usY6cGxubrVmjXmsZU9heojrBRSFUBNJq
X-Google-Smtp-Source: AGHT+IF5/A9g/gHD57+H8Ivg3g3/IAIPeuIqDTP9P2EseS5E1C+rm4rMi/1Yy80FsS4n3Id30lQozg==
X-Received: by 2002:a17:903:1ab0:b0:24c:d08e:309b with SMTP id d9443c01a7336-25d24cac50fmr187714865ad.15.1758059138768;
        Tue, 16 Sep 2025 14:45:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed266eed7sm530003a91.3.2025.09.16.14.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:45:38 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:45:35 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 4/5] riscv: mm: Add soft-dirty page tracking support
Message-ID: <aMnaf_3tInUXbuTb@debug.ba.rivosinc.com>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-5-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-5-zhangchunyan@iscas.ac.cn>

On Mon, Sep 15, 2025 at 06:13:42PM +0800, Chunyan Zhang wrote:
>The Svrsw60t59b extension allows to free the PTE reserved bits 60 and 59
>for software, this patch uses bit 59 for soft-dirty.
>
>To add swap PTE soft-dirty tracking, we borrow bit 3 which is available
>for swap PTEs on RISC-V systems.
>
>Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>---

