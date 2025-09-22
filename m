Return-Path: <linux-fsdevel+bounces-62352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034CB8EA7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92A417BC92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44442156236;
	Mon, 22 Sep 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ZoIfv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C51494DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503444; cv=none; b=m4v3lvMzNSdRMfHQFmUaO9F1ILZorlj+bqwnu6Y0IdoGKJUEJd++XEKT8Vxu+Iqit9m3VeWlKAqGT0jdfwXKG389jTUECMf0FN+Mzz/5MaRF714qWWerx4QFj+AdEqz2S3vZ/goOWHkifqBtNZ7MwxAwNYTvgBU6Y+njYifZSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503444; c=relaxed/simple;
	bh=M5wz9xqOwUfHtDVvMp9nzAi5BBDdS8BQxS9fvLMQ0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgdCfI9JNbpzhovVfV0PE9qEEOkrfE3tuVyrWfAv61Pv4SQ6vBpwT9ADIAYwSb8yIcew2ZVMMxg885MUDCuVsgGzN/Yy3BeTaQ+Fw7XESFctWrNGT3cIedvWeHWf4tEgw5Jxp4VeWuI+u5RQrgoGOg6tTD6UEv4448C2h9V2Z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ZoIfv9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2bddecc51aso79947266b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758503441; x=1759108241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=H8ZoIfv9DSR1/hp6JpXytlIGxWeyxbDOAgZ1ldhM7onVV0tw9ZOLtFyVaywrJxmn+j
         DDSO0l47Z9Qeoi8mnW2W8tJS0CDzx/NvkJVhlimIf6QKIIJ+++gy6ddVxb/s9NO0pzpQ
         ohzmZRk3iuXgw3lFYA7H+h1WxCaY5OLsfoBZL70HL44Q89ZHURlpvTdsndiUplxTVCho
         fAZyp7KXHYeyXPjrdAF1vn66OXoDvfbpVzF8dfzqdB2GHL+PlESDX9nsyW3SCBpSNIgT
         mc6XdOXDZ9DtNg9H3iTRCIgrA3VDrI7X1OGGvN8K5Dh5Y5kKrB47Wt3Bw++oZqh2fGcQ
         tCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503441; x=1759108241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MkJ7oUnUH/4XWT8grjBfyBKEOMi6atBFTqk4gqmuuc=;
        b=g2AESJmJPW5sea/utf0b7GtuMg0smiXg3UVuL6by/h0HFEenIJhdeNV4ahdceeAFRJ
         rxxAl0+OegMNtjDvqkxD2wFMiL7uot2uU1hMYYldPzVCh2Zh+DtLvra0Fs3PIgGgibVx
         w/dXFzwXhGsTHbn5DkZAJjIekYX0UVI1VkeFVjvzJDWOumdq/zALOdilj9VdGGs7Nnhf
         u5rVG6Tpsn5mAidGwXM0ZmI/HrB/p2KOZXlolNJqaE2w3u+JACZ0CIO4xyANfLZ8Jf01
         sbyCWlhOQgUpCoxtgI31HayktaZ9Wuykvu8ou5L2XL6feGf9ZMQssaqxiQbryDFk8FdB
         ldrA==
X-Forwarded-Encrypted: i=1; AJvYcCWsCsC5a6SAaoApMTEv7qTsA5le4wWKRiAtXAmbzYbGdiez90QZsDvFHqwX+pf4OLih4a5+rIdB1w7vXLy1@vger.kernel.org
X-Gm-Message-State: AOJu0YwUN70e44jC5XyYBadhIvyARvxQJT+bm/gazIJ3bczUZEePBfHB
	IhjHRT84yza9vzfeSG7fLk/A4QJhHmkad4fGG0468K6LrKy3WRGsbuGU
X-Gm-Gg: ASbGncu+PyS3XxHabGdAoWxG7CSU+THyMGhX9LW0OWuf8kdfZ+RRu5Mo7bgHz0C8AtJ
	VQa4N9wDof0BHTZqVT+1UhEaEC5S89CLhHGos4n6Bu2MG6slTHT8TYv8PfuNRfd8IkyLR02udpt
	FLoScwRTIAif3GC/N7o1HDCIhHkW+wDhrp7xvKSAiL6q/v+uslog/G94ZAmAwtjrrk37K3jMHIO
	YyUvpr4CFFzXrFKn8KIJPcu4MqJiEbUJKmHZ3CgcjQcPLkyzbmF2NGWRUf9qb8OmfU+dB2yDQiK
	+iIupgr59hIPNKtDFcRM3qQoKSvLy37z4b+A+s5rqkxJ302FmDBctLjeYZgrWSJ0NecQ0gMpDnG
	1hR0ylEbnfcJN1qcYBo8=
X-Google-Smtp-Source: AGHT+IEvTen8ntQeNOQqNFT2eKUrH0+zq+HnLQQTKn/Su0UVk9XUetSFBmS6KjUaD9cJm9/WF53iGg==
X-Received: by 2002:a17:907:d0d:b0:b04:6546:345a with SMTP id a640c23a62f3a-b24f442d830mr1120956366b.52.1758503441503;
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88bc3sm956702866b.51.2025.09.21.18.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 18:10:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
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
Subject: Re: [PATCH v4 05/10] man/man2/fsmount.2: document "new" mount API
Date: Mon, 22 Sep 2025 04:10:34 +0300
Message-ID: <20250922011034.96618-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250921230824.92612-1-safinaskar@gmail.com>
References: <20250921230824.92612-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MNT_DETACH, not MOUNT_DETACH

Same for open_tree and open_tree_attr

-- 
Askar Safin

