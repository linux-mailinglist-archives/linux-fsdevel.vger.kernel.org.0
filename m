Return-Path: <linux-fsdevel+bounces-70982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1445CAE248
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0DAD3001E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40592FD68E;
	Mon,  8 Dec 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY9456hP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m6oarCqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01720298D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224826; cv=none; b=Paw5rihOgUmOEVlVTNb78AkEOkI1udegCsGVfcNz3EOuBqRmV3VlLOUGb6VdlQq2INc3T65Qd1LRiecX0pcHla9+JQ8rzNgfGBlOkir/ocAemkNNu0L/rLqMIyqZWLWosIS9G7331jIZ9fENkE1KFXHL26v1CCqu5sb5nt9odNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224826; c=relaxed/simple;
	bh=hw2r+rl+ML0kBasHo3DuWSxhXpJFJHCC/navEDZGDs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABzksXq1V4XKJYtbWxQnmZzc6cqfY+UzK5y4fL8EH6g0EN09+Y+lRkYMjJZvF6hBS45vrsbtwqcA6ISfeghktH6HFvvyVCSMyZ50qGPrkGJe7vUEncPAtPeLwUi68N8yW8+EiIDPL9GDRa/gmaqwyvCP0xWEVVMLMStb07Vg1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YY9456hP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m6oarCqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765224823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnuyGoINeX0/FVmpJDoRGJ/KBS4njE8IhIrsXAd8IiI=;
	b=YY9456hPtru3iizN+GrEQw+scGDVbnE6mPfO6OEVImt65Q4SgDSG2oG8+o64i45m9CqFG2
	la82tzq4ljTJEH4itTjK4XQzt5OCpqqJ+JYq8d4dlD0a85JGylpyIfCQXfAYaq5WeecLNF
	Q7GtAyztdmiu+M+q8UTgTqbbTsBYNG8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-F1YmwHe5Nve5J5u3t5qOYg-1; Mon, 08 Dec 2025 15:13:42 -0500
X-MC-Unique: F1YmwHe5Nve5J5u3t5qOYg-1
X-Mimecast-MFC-AGG-ID: F1YmwHe5Nve5J5u3t5qOYg_1765224821
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29809acd049so111117725ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765224821; x=1765829621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnuyGoINeX0/FVmpJDoRGJ/KBS4njE8IhIrsXAd8IiI=;
        b=m6oarCqd0llCsAnexFxoDQjjCMlA53+QJqr/E1/7/jP/ZgJlEk9/HttwVdbBHgjBX4
         RBBf3m97E/sQEw25pPSMWAKWFsGBGwg06IeudkLrHOWjpyxNvtcBaG2yU12IWVxvHQyb
         d0I6GwM1rM15GHlc1UJnb9QQhnDmOnKL7lhbsQ9BcqQw4Tw8Ad5+e+26zBLXqER4ZQG+
         F+pwFgs6Mg2icopiNj4tTiTWsGWTWU3IX7Pyf6EZje6oSF96wjuAKKiBmEQSRmmUez88
         nSBxRHauAFYdNSIsTp6fL+UIPxja44JQuaK4vLmioQcwjJxc8snoU67NstgpRUx86E4c
         9Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765224821; x=1765829621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnuyGoINeX0/FVmpJDoRGJ/KBS4njE8IhIrsXAd8IiI=;
        b=ODF0X7OkKhaYJqEGUcB+WusJgq4nAdY0znMnwj8ebCFu/772Oay+A0+3atE+fgGZ61
         3+i+MUuqTUzOZ3uZmeZKA++ces0nCXW3SVY+2Feb34fmKdqLA4IHOLJBZi+RHQDrptsC
         m8ccoRc7P32HUvAuWAlvpGHyAsbhx4pZpcMhc00N6Q+8WDEggB8uEtrM8YRIbZwWLsdz
         1G/O9u+pAThmYjn0k3fMNxfR0odNGZ9D8wYLsX1t221wThKxCl56JtvYqoXTPnozTRKY
         VtrRPuJvecUI3tHD887SW0NexK0Kb6i+i4O6z87XwIWWG4bNZOP7uCzmvK5YWVmLRY/9
         pcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Dfc9BbC7HMg/N5K8u9wsvTZCSd5KyZb1LS3NTIff3EdchhhL5W8XDKcQW5JbkOP2GYIwu+q7cNHsZaXk@vger.kernel.org
X-Gm-Message-State: AOJu0YwIG71m5taRNHZ/brwXRkqy/uTvZn7JuRSWPg/TN6ISK6/qPuF5
	i6rRu4I3Z6nvypUgZPpwEvMfhGSdhR2oOYW4DzEg3oIld2ROnnFVsJgGy73c3Habbd++dROTQLj
	y1/6LiffwLKU1dADiSIpEr+J+IxGfj0yUeEtVYEz0NI8SbC7J9BoNBsPN7h4qwflJ+A==
X-Gm-Gg: ASbGncstm9Stt98PiT5OOMLCPsb8S7zo5mCwXCMgcSR8hVLCphvYtTAyDcjBti2FQrj
	kOru+ZBPJ8kNtqzm8iwShVGzuxwJPpBlj+tAj5Geb4VWgkXQxT0CstC6jiqUmpwOPOyVGxE1Jmo
	DocKv/vD2f6grjR3RzgNAv+aQhwsRfcsGhf/JVrpWscz+TQ7o5zUvWUVtsSfoNewzzZwPH/Y0xt
	1doiUZSOS/yIUEGycjU1HXdwSTXMgZZNJW0dGgL7wgWUlic6CuTlIEacWMvnAUM8ySoEjysWzG6
	/REcNV2Usmayo93P6AUCN3QGqZFDSsaX1XmMvmQyV265kzhA6XJP4Z4Fj39B1uuA4q3xyxZYkcC
	fL0YiUSyNz+uQU1Ve2rElL/xuxLkiSqotbxC1Nw==
X-Received: by 2002:a17:903:234d:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-29df5e1dfdbmr65988085ad.38.1765224821159;
        Mon, 08 Dec 2025 12:13:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErKmIY64EAkdGRE1QBDy8ZSL3n3zcHjZvB09IVFnpS1fs2iXh/uvlq6s18xDdGczU5ChUCtA==
X-Received: by 2002:a17:903:234d:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-29df5e1dfdbmr65987885ad.38.1765224820771;
        Mon, 08 Dec 2025 12:13:40 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf5fsm133395645ad.78.2025.12.08.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 12:13:40 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: djwong@kernel.org
Cc: brauner@kernel.org,
	dkarn@redhat.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
Date: Tue,  9 Dec 2025 01:43:33 +0530
Message-ID: <20251208201333.528909-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208193024.GA89444@frogsfrogsfrogs>
References: <20251208193024.GA89444@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > drop_buffers() dereferences the buffer_head pointer returned by
> > folio_buffers() without checking for NULL. This leads to a null pointer
> > dereference when called from try_to_free_buffers() on a folio with no
> > buffers attached. This happens when filemap_release_folio() is called on
> > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> > release_folio address_space operation defined. In such case,

> What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
> supply a ->release_folio.  Is this some new thing in 6.19?

AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.


