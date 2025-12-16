Return-Path: <linux-fsdevel+bounces-71491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8DCC510F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8222E304199D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00832F751;
	Tue, 16 Dec 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S89KkUna"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE31126B755
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915746; cv=none; b=Nnr9FSdrEEEP54NQ4PIWogjtolOJ5Jdc2etcR2OViVMkyVh68dEJe9UcTV9kTWhGpmDYffojnbWFnhVZH/tolQQ55n+RLtIWDQx6OQ9yJUlsT7wwIv/YDZc1bSwv5R5s4Fnj17xZ7cQ3YfP+VVBwfARXg2Yr2kvnbKlx/XOy3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915746; c=relaxed/simple;
	bh=kIhSKDmibiZeir6cA6DLCbZr7ql+u1kAXnIHyYbuQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS9C2vd2/9qR/6aIuwfd1t1TsPkmn4XYZWDwdOhoXJwW9yVJSkUufcz2t67O5ZFvnF5jcptKpU1m7ZaLPAO8rz44yu63UBhZLFs6Y+EnScgDDGHJbeV8CSn+FbzV7g6uPr7uE0r2NgEXiplhcwWnNr/jsCIJQFDkBfiDY37RMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S89KkUna; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-597de27b241so6408605e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915743; x=1766520543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1bbnR9hzdM9Uf+6FrzBwEhl6E+6kDOhpZpgPAvE7Vg=;
        b=S89KkUnaqoFYdw+5He12dGILB4/8WVzBmYaCGuP3wwjIf3verZO3h6yhqkOveTTiFq
         LLRmQCsHkx5+7+2ewLHHcvZUNX3m9EUK/eGK9H6yyjvpD84WNI2z/h29RkkSHnsJVz0u
         ioZaACbEapFKrhQYPw1tHEys82hqDeXLwE9YNcAncM+Rm8J8FHiff+ZE57RdDLMvxuMU
         RO2rS41KObHDdH90x+LX6yqN6t7G5eqpBzEUjzwroaeySr8T3DWT6hEfrO8gpH993xD6
         3yFOhj6uzg/buohO8t7tMPhrXMsJs6fHz0aiogAzJfozYdKGUpOyCjJ2jIe6Dk96HSDR
         hqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915743; x=1766520543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1bbnR9hzdM9Uf+6FrzBwEhl6E+6kDOhpZpgPAvE7Vg=;
        b=WXK23V/a6GXz9rJIMag/Rn0/WgCbUAJSy9xG1ndsIYLNtCDUl90SZpNquGwAhszE6S
         E7pxbf9eWNFg27fy6muN962zuNbE4FAvXPrxHi5yFe5F+qBvtXCTKZw987g3mayfaYYY
         YNlWg2R0NMhRYrMEfQMvRn3lZ8M00/w6GRE10DDfshicGD2hiqQ9qECKXi3PIbFjMoO6
         860n9ufUnlwyTsH8STXBSU/mmbIskphIV7IyYisOURovTR7ROVAT+ObdxAYIueplye6L
         xmgpWlvN6unyRKcMjORjzNF19w3ZF/0SwlP0EBAOOQCKKMs0mBAszqjYqG7B2nwEq2SG
         Htyg==
X-Forwarded-Encrypted: i=1; AJvYcCU0DydIvpKr8+7qzAyLvlhZl/O9vWPeGJU/q/az9yfcuJQzXiBUs53vrTEJdXumiB1yEI079Erk7Uvnmeu4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oCsotTHqxcLD/QnhRTHOWhYu3gZ3ujDxafuKhPxY1lirknvx
	PNVj/oTesv7jPgdL+R99msh/y1ydIzJOYuayLdXrEXudhF+eKsmrdoyr
X-Gm-Gg: AY/fxX7CP8U66Bl+diTeH0NnhiI+G/63mZDPxunJcbDNVZt55dFJmAE5QpC3u16zI2k
	+2/p2y3+Uep8WEVKaiV5flzf4D9FwGz+18juu13rPctfd/KMzDsgvhgBpyKsrSGlqN1yU8wmhUu
	+H0cnmu/VbXOOQnlvYRwyA80xmngjOum6J2UiW30F33khmbloosRqFzyb5xbGk28Do6sGAKIR0v
	B2nGD1VU5QmbXDXBs7xgl+mM1Fl378PWLwTPmnQmfHQUDfrxjoJ2ypK8hM3/+G/hkoQnKNoOze7
	M5NCsPBaU2WV2qbde4U9E/lfNqZYl22jDUYt90bi3dwg7dWZfiNMLdBZzMqqmxvG7iE3rPDthz4
	fhWlPSxQtF5sgF8tunca8xFgvlTHfQ77Q/2X/RGP3msAUHM24QAjK/y2h9BbVxf4Y4p21kBthbF
	26BknxfL3I
X-Google-Smtp-Source: AGHT+IFV1QMqnFEYIhxE0eg69fEl9/ql3eoaZPZV7PrMeB7/xLG89YWVuYGgHgekTUU1ROL/2OouVw==
X-Received: by 2002:a05:6512:3ba2:b0:598:edd4:d68 with SMTP id 2adb3069b0e04-598faa5a3bamr4551753e87.28.1765915742645;
        Tue, 16 Dec 2025 12:09:02 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-599115eb95fsm825534e87.19.2025.12.16.12.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 12:09:02 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: audit@vger.kernel.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	io-uring@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mjguzik@gmail.com,
	paul@paul-moore.com,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH v3 27/59] do_sys_openat2(): get rid of useless check, switch to CLASS(filename)
Date: Tue, 16 Dec 2025 23:08:58 +0300
Message-ID: <20251216200858.2255839-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216035518.4037331-28-viro@zeniv.linux.org.uk>
References: <20251216035518.4037331-28-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al Viro <viro@zeniv.linux.org.uk>:
> do_file_open() will do the right thing is given ERR_PTR() for name...

Maybe you meant "right thing if given"?

-- 
Askar Safin

