Return-Path: <linux-fsdevel+bounces-62351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D3B8EA6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 03:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582383BD3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851B1514E4;
	Mon, 22 Sep 2025 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu7tvw2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450981720
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503218; cv=none; b=XhwmPCptkyWq1xv93M7GzYuz0BmkokVVOnE2wzVG2ECQDCQI0ieHe8Abw8SCmrg3Osh1pugv/PTKYrdJmOA4JjuxZ1AzB386txxWptrVyb94lQeJC41pntjF6FKSf1VjtZA50mS6L+6eTZghiN82/7XDyuEoWa8p8gEEAu0TOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503218; c=relaxed/simple;
	bh=asv8V9+Gueu0sNN+f4Gl1Qt3MQgb39wz7+eIfVPVXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAHXk+xcET7wiNxBaX40UNZpeQHc1uTwWU5NwNcC/bOSDR0Jg7gBfXCmEgMpJMZgVWbWlvJnmBLQ9XRp60jSmBywGq3J0jrqw1Vx2FKjeYvpmhXvpsF8XiIqZXV52mRnhj3tPVPqMzUJQgaeIQHodXfmgOZhgDC+mkLCwib5vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu7tvw2M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07c2908f3eso570618966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503215; x=1759108015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=Qu7tvw2MYaQL0yImQzNFv+BBEyaSNuF2pxV9fNky6RwH2DzTPNV5KcHGZ16sLApyrn
         agJukdp0o0We3p5OyBDueUIrnDoMk0w9qqC3CVi1wiVbgZ0jhDyYS1xasv6YyGV/X435
         ampdDzP96gOwodws6vcJq5XbN20F4N8TFwIbMYAIoenv8egSyAdV9Z7XugJGoBVLPP6x
         vX0sWgMA+v9lGWezkCzqO1MM2w27+1pNJKJF6WeQBmMBkC5pKrusxeEnHnYRXFkpvCG/
         ARcMFtExxR27sDASnmWXmJ03zYnoUpk8rOmdSg03uEu37hXsbYXYau2mnBS2KgU8Mkt2
         yyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503215; x=1759108015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRFzPXWkpeV/mjt0GnDfb09q9PXvnidCDKuEHBnZ7Yg=;
        b=OxSexpnmoytOas5aeUfMlp9LhIZVu/lWZIIVMmUnWjuXgAj2Pv/8uh4dTZz1tjSyn+
         2gqUvfY0InNaQCeleeYvukjFtePaKfbkp2QDAU9O/5Bp8Z8RwxlamDZs76ZYHUBcVJyc
         qtePn7Ya93j7EoLS8y9n1h9PfnAroeF330vRcmHKP4sDMkt9H8TMpx7FRI8EVPfr2CCl
         ToEIcofzzA0kDClZ4iGVvFqKznGadkOHvI25UK/SnLJfKZApVBdtAlHL13J+VxMv4JPi
         eHnQvMBZRdZv8sKHgUVNfmquEZF5ddogPxGY7vkeeViTLj6UFvP/Gt8UqAT3YVTKi+zQ
         tK/A==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ap/LA+88P4o20eBTNixk8reuNrgI3USAEd7DVLkWDvbZpl3w1GWEU/EGFQi4yH7vFqqj8r65Zes4QHKd@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPPDiAmDxKy1vn0kFu27WAY6UA9LEFq44aRa7T6KQHLUB/oQK
	eTPqgWsbf6Fa8utBzDr79MGaqqJvAXKpQWgPEGIKURajP0F0o7WvpdZR
X-Gm-Gg: ASbGncv97dstOcuUKtShZ9PfMTjk5CdCiOsoiZSKvWQkA6fuupn4YvonlX5u2tGevxE
	pScj9VS7yGMD1NErv+qAQ1ZOtdAW0/l64jMesdESYgGGbvYWwPkGG+jVitRTWMafCfJYt2y7zfV
	0mUrsgZA8fTdbUAHlzswtq70lRLqohIPxN6GaQ/3kkzOwUSA0vw/QKTXbidJbhKypJGMu4xJ17i
	LDf1lKbWUl6sz+xoD7Iyv6DQAqABTsdmyLkSe8DMFgMJp/SMZUTE/83qmKlMCjfJ62/wQnzHPXQ
	Sbn7KSrFToZaUxf2hnaIzX8QNy3Y10EU1TlFaqqSMvJfqtqukTwT9HT4sBs1wt1YmnUulMw24GE
	YFU6weWw6k1MHE2P4Rf4=
X-Google-Smtp-Source: AGHT+IEE+dlkZ61hvZbcIoJcLnr6qbKVmAfG180HpIGplBEyYngiA6LG2BlkeTTj4jLmF3uK23VJkg==
X-Received: by 2002:a17:907:3e17:b0:afe:74a3:f78b with SMTP id a640c23a62f3a-b24f6120e79mr1092368266b.59.1758503214799;
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b264fc793f4sm640643066b.17.2025.09.21.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:06:54 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note about attribute-parameter distinction
Date: Mon, 22 Sep 2025 04:06:49 +0300
Message-ID: <20250922010649.96399-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Some mount attributes (traditionally associated with mount(8)-style options) have a sibling mount attribute with superficially similar user-facing behaviour

"Some mount attributes... have a sibling mount attribute"

Something is wrong here.

-- 
Askar Safin

