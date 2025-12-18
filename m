Return-Path: <linux-fsdevel+bounces-71625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14DCCAB62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B775C3009A88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6C2957B6;
	Thu, 18 Dec 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tn+Si5sm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AB3A1E6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043830; cv=none; b=sPJ4+1zHNoyYueVnzQz4K11d/zB2WWTlRnW/bOsnKA6240uyCc+Xf7V56RjLQvbG8IhpzUDHEKiBfUNylGz6ofyF3fJbtGDnBM/tZQM0rVOcQUE6ZFW/vu/ICp5+o5r8ZOoGLDb1GCu2V6d/SjkdzlOS//u7XOLunbfR54N4bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043830; c=relaxed/simple;
	bh=w1/jZxBNDezWgWd+eM+PYbFV4TAzCe5RPFrAY+wrZak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IgESU7gigOs8FUrpW47azdIv1Fv8eRLQEz5Ye+lTXMCSLp9BGozPMsHgO+x35SPWGODB5wKnAqQsRGjCak/epsyIvB2dnDHNtwjr7xSgconB54qlG6lErvAwv0hACtxCBlS2z/azidKRndxqB5Sq0H7vXRmqs95qmYbVw+ylz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tn+Si5sm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so2401015e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 23:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766043827; x=1766648627; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRtnZTPvmNwyrrx/TTk3QjtQXIY+7MtK+eUUblst+Vk=;
        b=Tn+Si5smKeHatB6tUP9fVYTX7sIm4+BjXsc/rJ+JzG3NYawDQMdsCYaRcBBGQicQmy
         f6gT8x9gX4FOwFhE771CAo1tx9dXe+0kRJ9PQHz9RpdPEgfK3Pd8d1QfPmA2q/yJDATh
         RpSpmf3cGZj7OzpiszPvyHzrIEvYx+QZtC2GGKofQDXIpiqEQOdszTH54Iddj8ryO0SK
         eBXRgRuUOmKscbV9EWmzejyKtlRIYB1AOujZi5qF/779tgakxCiAiDpR6e+lhmp8fsns
         0XZeZBH2Yv1j0jM9aCMfftK01csD423tpEcnk9+PJRaF6U8YNTadQ5Wyg0cWaJzRs9In
         FOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043827; x=1766648627;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRtnZTPvmNwyrrx/TTk3QjtQXIY+7MtK+eUUblst+Vk=;
        b=X0cXaH1jCZlNSWyxoNrNI0ClEPu3uoTsMI/UHQblD2DLBGE4s2+YK947fYHVV6zFzX
         HKFEobXNBN/NKAkuohGuD6Gus95DYbKrWdoHLwT6VfptFEGiTDw8bGdfAP6/vRjsqZr1
         3s9iSJSFcbWhtqjIbeyZuY+7eLpYSTj/tVYS9JKHkwaWC5wOWa5jHYcPIFBNA9CZozZA
         EUpHn4uXxaWDJ3srpT2xFADB0+sWIZgDWZXEM48KcvosQXl0bywZjbmAzC5xQq+07VjS
         fD5i6FE43PKDxHVaDFCtnmw7iwUyrQHdEYbiH7uKkWSwwNoA7m6w1HwsDBhW+JjYpCc1
         Yw5w==
X-Gm-Message-State: AOJu0YxxsElAsYlqZuzV62IOpOMc25uex2S0uUo+4zjWUnOJr3pN5/Qf
	pJk+fxn7uQ7Qcds9TwaUys4Tm0XR1m82Uqt35ks5OEz/Y+ezZdvtRz7ZViu1O5IHwGtRJ5acTZT
	qTSto
X-Gm-Gg: AY/fxX4u/c5foHhJbBwC0Po5Sd4eI5QI6j/AOrpxbFqR1hzBnuI5ZyA/P4itVMwvZYR
	Yazps0Fp9gW9TCiqezfzDeRTxMvcxGshWaVufpcBRJg/P4HAHn3SbViLUFvbDYBvQ/JrDZkc6gf
	ET6sdOdfveINuMwH0h52ZvLBk22FAm5Mx8NBQ+aedHzLyDvsHxQs5KjaVDSNgOxa6utk5/BOe1h
	m9hrGH+pOj/vIyRoS8mNrd2kzQxUYpw8NqwoayYAno1m/cVVyB8/CW2eQPZaXvQRMt51p2s4Fi9
	tsxNbceafjs9og0LnYZbGFiwek4Xx+Vylq7VRNepEq/CIkqoHUezNWsQhYsnHYBIN9xpSk8mASf
	9zDs6AxnZy8bk0m7Tmqn32EWzXnibaRlItaI0qHCBaCfzS74IYR0LMyQp/Gx/27ZFJUSvIoV8sh
	6Drz0dkOhluGChFAa6
X-Google-Smtp-Source: AGHT+IFwLm/MBnBV+a1J6cOf8KXauVSG8mY7Zx8CckkvtxMyOJ/7oq5HOLyAkv8pHQ30DECeeq8+PA==
X-Received: by 2002:a05:600c:8115:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-47a8f8a9c26mr206553645e9.3.1766043827397;
        Wed, 17 Dec 2025 23:43:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244949ba6sm3440552f8f.19.2025.12.17.23.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:43:47 -0800 (PST)
Date: Thu, 18 Dec 2025 10:43:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] xarray: Add xas_create_range
Message-ID: <aUOwr9s7zLxK-UVn@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Matthew Wilcox,

Commit 2264f5132fe4 ("xarray: Add xas_create_range") from Dec 4, 2017
(linux-next), leads to the following Smatch static checker warning:

	lib/test_xarray.c:1715 check_create_range_3()
	error: NULL dereference inside function

lib/test_xarray.c
    1710 static noinline void check_create_range_3(void)
    1711 {
    1712         XA_STATE(xas, NULL, 0);
    1713         xas_set_err(&xas, -EEXIST);
    1714         xas_create_range(&xas);
--> 1715         XA_BUG_ON(NULL, xas_error(&xas) != -EEXIST);
                           ^^^^
XA_BUG_ON() needs a valid "xa" pointer.

    1716 }

regards,
dan carpenter

