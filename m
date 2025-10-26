Return-Path: <linux-fsdevel+bounces-65640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75025C0A703
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 13:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0046A3AC96C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50C258EDB;
	Sun, 26 Oct 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpI7gZPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBA212572
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481680; cv=none; b=FC8dsrBdbj3CY9BweqJBk9pJFh7vrl08fyeD0hFvil86fe8SlD8gplobjPXU1hPjK1gegBif9pQnnVGS1qmpDBiYNsQyFEsnjckH25jJy+Qk0e8+V9TAjqp346+4r3WzQevPShW9GAiOO0Xdq/9L1DSUOK+c+ZG4YYk7iNvfTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481680; c=relaxed/simple;
	bh=96xgEF/cDhtXAWfkTUNwDGMDjcisf5kN8St/i2PJMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ0geP1tKNRPnk3uCiXD8fZBLgBJ8IGnZ4Spp41wcXzX2zxxqZjW1J5cpudNvCn3+km1Yq1v+E9RX3/WYFv0BzaksTMBrbQ88cCwUqzKBG4HhdexBzj2hqmJihFhDc2pRzWKbcF/taNI8IkLOFu9DbKFMO5M5KN4evS7sZSvQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpI7gZPH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so5583230a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761481677; x=1762086477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=mpI7gZPHdQ8TTyod60+eGIxcs/iWH3jWkmzTxX+jc8uNfd6EBHLpnWAH6Y6CeStdPH
         Fn5IVLPB7bQ2JbUn3kqErMQDlzAh/WAtSdYqOmqQWrG9LPitlSmghihc/KnVs9f1CKjH
         9kW8q7rgcAUhGxGixlfKPorsP0dWOzZw3pEy45tyYZW5r8HrfvUpp5u976f42RlQEp+o
         3x8sVDD/E5m5sGGuQL91ozMQ+MnYMc8pwkyhntxRk/wTc9LaBM3EsyMieHN5oYnOFGkh
         G+2iDdYQG58kgaE+bd/HRL97opcdxSbkW4qRFXUpPgXoS3mtdtj7RTpy7VIs8UyqzbIH
         oyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761481677; x=1762086477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=wmXYR9pTZMmH7Tke2ogkTczoQ0d4gOecrfIy3kBosm/h3bdehsxLbAx0Mcd4BS47aO
         4bq3eujYqVcOxDVJt3l9P+mrGo0hZg5GPNjTm/GL3ozYLcwijiRqQK/pVcXU/HKrI3SL
         jh1SQ624l63PxjlVP9d25SybOU2yAjzQoVBUb3lwwmzxclb4QN04so7adQzwTVkHYnFk
         YUjp9GoiagdtZeVx9ve1QtkAHatTEA6EXVrdONxVSSahCekz+LW44NbJkN/c9jc6nuXn
         29oO7nCDdj9swJ86bRlfLS39ZG8j12yl973DAdW8oKAOxw/8Ro6lHIncYWOXkKw6lR1a
         BaMg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ll8YOzutq8+z9bR4Jt7m73x/VUjXU9BXazT5CGj0zrRm9vQWVUAtFHixzmBZtGrTNZaJ+pIUqWJgvY+r@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5j0hLlKffHOBngaBaRBWTD9r3XCs+F+wp1wIR8KMSBXJSgiL
	A1y8p0XN1WsE6wpNgBVqz9bBnHRTRAZGxGzLZCVXlHANZ33TiOhU4k3T
X-Gm-Gg: ASbGncty+46qoSvf9Fv+tYEafYYwiRUEUfI7xW87Xe871l8UehkhtQVGebxNlxFKvjL
	tUvPGX46B3NBiJKvh/mw5ddgNzypDHfn9cCudgZqQ0j9F48DtmnjIvP9UH10QFhBF5OoWkUtl2i
	IvteUs1aTKjoDjNjOnfLkUf0qaTuocGugnqSS8L3LhDZPQcMxot+DZBUdDhHMb6oqU9FSjYKAU/
	9oRd+s48RVGqULwGRez6b3bOaWwtREUflEgQaM/baW0NRCokmQjKwZuOZCLjwBFrfuEcAqZ+TG+
	/YbafuXVj0hi6fwgvXHd99nqr+t6vzoaax5efhriKFNSo+nKODe90ApSLsZwKmVWfknr1QvuLmV
	VwLiB0yPfpCFZdhD8f7m6wEXO1rb6tmLZMdtlr7QEnVwN6azm8tFRnx55VVrX/fe82bq9wM177o
	Sg6D0VjoJ13C7uC6oxkWMcXQ==
X-Google-Smtp-Source: AGHT+IG+nghLDB0dKUqOb9CoFdpZ3LvT3sjNG3elsEcJPMQmBpgpXzecd9vKXOr4yry1R2RtnfT9gg==
X-Received: by 2002:a05:6402:430e:b0:63c:b2:c656 with SMTP id 4fb4d7f45d1cf-63e6000378amr6445996a12.4.1761481676685;
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef6c13fsm3796082a12.7.2025.10.26.05.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: alx@kernel.org
Cc: brauner@kernel.org,
	cyphar@cyphar.com,
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
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Date: Sun, 26 Oct 2025 15:27:42 +0300
Message-ID: <20251026122742.960661-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
References: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alejandro Colomar <alx@kernel.org>:
> The full patch set has been merged now.  I've done a merge commit where

Alejandro, I still don't see manpages for "new" mount API here:
https://man7.org/linux/man-pages/dir_section_2.html

Please, publish.

-- 
Askar Safin

