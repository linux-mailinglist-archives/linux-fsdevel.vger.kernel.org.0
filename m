Return-Path: <linux-fsdevel+bounces-36620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD0D9E6C63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CCA16CB0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EBA1F6678;
	Fri,  6 Dec 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNXvgUoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47A1547E8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481307; cv=none; b=ei1aVjSZWkwaMZ/u9uMIyUvurdWYEEtcmkJSYkwwIBjkUHYuaWNR/q65yDmtxP4p4pQX8g+xGfb5TA2hod0bqElLxK1HCUD9mzPHaTGre1okoO+IVzlMdoMRGWF7GUZkNS3ocsBnZIms5UIgBCWZ9kYfrmQFDQJv4D+h5BWRI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481307; c=relaxed/simple;
	bh=0XDQJcv7iFgLJ1eWmwMJVBYilr5vQAJLf+vmjZPp3b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4HyOS7N64t4R3/a4hfoRlVIRgtz52TerhKh3dfGSRA7tZp7loxKytyAElBsQ4flxEVyvqbo70JouO+7fKQZLnqavqSFt+OzHasg8CoriLFHh4jnaxBSXsdgObJS0Y/N5D+3pXwtgsze4RDnWcNDs74W4emNJJQhwQ59O0uMW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNXvgUoW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so17648071fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733481304; x=1734086104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XDQJcv7iFgLJ1eWmwMJVBYilr5vQAJLf+vmjZPp3b8=;
        b=PNXvgUoWe83vzQS+yEVCehmTUWq+qgKcMW0MruIIuqmqn25ucr4Wj6bZlK/esZ7SzN
         g417KQGIKGC6FhnHk6kxqjrVXB+yj6vH51JmGsfXLLfURPuEbQdT35aKq+zWdVbAIIRb
         TKY0SSoOCXtNGAX4SSZaIxp7KUHdjzyL7oyNN5yOIUA1G0yrG2nbJ7CZmze2CTX3UKDs
         ZHQBrHLvxGCBe2B21Yr53fO9HoI+AOYHqw60mgdhO7FzzfRWooosvBEncUnn5Dzaap7W
         hS0y7Ibb6WY8EA9jUrFDM5DXsJ5rzU5YA7aWnO37qmWpnaaUXphazGVUE2UqsF2IbWPf
         FXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733481304; x=1734086104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XDQJcv7iFgLJ1eWmwMJVBYilr5vQAJLf+vmjZPp3b8=;
        b=c0b7tVU9BQ0DsGZOmaPNHQ339UsYC3YeFJCE/Rx2ElQ4W9DQcktJHaEVMgP8/agagn
         sdT6bNM1Oqzgtvvq3lAEMjeN6/HkNe52Getn8oNv0ibso6YTwB6L1u/FJSczAwWuSKMH
         4b4MNZa6KExE3Yz3FB91DuL+fwjilM17E1dGuvuNSY4exVqIquOCOsLimDFCR5V4WPZv
         y0n/dBq8d7nsmk4CIkbDmePcRb91qQlTqaH4SHvUz0V5F0yWOa4i3T/EQbP/aoyAhpYO
         KlMd/vkzD2O9J7XvXtX0orfSiIH0aKTLpEgEwIDX6DGUCFDOYKRvstSmYCVvdbiPp4E5
         l8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5C4GwWdvc5OQ26H1EkoI+vYxrMUq2qkToZuNNis8AFhK4+a5fxElWMUPjs8ZwJZixp2ykYlox8NtjBepB@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfX+M4w1qp8iEgEAWJaP+G3qenF5h8OGI+HN5sh5Qxd5UVwBh
	/QVG3UD4ylnHF50/PeS9GkKk3ZWtWNdp+fj/bBGMRkpsMFcrQgG3E3ZY6TGqbmmVQojqsQcGYZK
	e+ac29RyXRkXLU/XYDcK7kOg15gc=
X-Gm-Gg: ASbGnctZGpZHTZG/yUDkDZHcxaC7Ggo0XGlKtUblAW8em1+9KTB2caXluYdfTUHhQLy
	ttfd6IpQaTWPemtKF2NFYEyWfcMhQhfPqzPHPaDkZh/syYqESmiK+nvNZcy2tS7ZyIg==
X-Google-Smtp-Source: AGHT+IHE+blOmNejIbE2J9tXQkOJ62/o0JX6wKdzlYgRdn3batbpbCG8UAnrCp0EcL4veN1WJdz5TGNsKRD4QUCNwDE=
X-Received: by 2002:a2e:ab0f:0:b0:2ff:c242:29c8 with SMTP id
 38308e7fff4ca-3002fc6695fmr7209701fa.35.1733481303841; Fri, 06 Dec 2024
 02:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB6129DFD4D1E8805D9EC930BDB9312@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6129DFD4D1E8805D9EC930BDB9312@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 6 Dec 2024 05:34:27 -0500
Message-ID: <CAJ-ks9nHr2fCJCbS=wx92Bba1qdmOg8hJvmenjKgEgvgfWL=9Q@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20241203)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Chaitanya, my apologies for the breakage and the time spent
tracking it down.

This was found by automation and reported in
https://lore.kernel.org/all/a41eb55f-01b3-4388-a98c-cc0de15179bd@kernel.dk/
and the fix picked up by mm in
https://lore.kernel.org/all/20241206012431.4B593C4CED1@smtp.kernel.org/.

Best.
Tamir

