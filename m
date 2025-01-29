Return-Path: <linux-fsdevel+bounces-40317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C92A22283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF933A2641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE81DF255;
	Wed, 29 Jan 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NetKKcJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E021DDC19
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170320; cv=none; b=kpBw07alyfpKiNtp2Kn0BzHE/Fa/48QNuCaKPZN8ezfABqnXPMDMTVX+N4F9nzPL8rsPIFkGFylY/654mOaF45tcLdEWJbkM8tw+5Sn7oi6TGzyTDDKyVMTN4NWI7FH5hxHn6wblXNKm/SY+2aT3amKPZZIfrVFlQHy7eg6Pkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170320; c=relaxed/simple;
	bh=HLMiW8ZmME+x3YSqFpYYA4nE6Pg/LL0aigwIfwylVkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrGa00Q5hPFxiRiIePgUzMZeehVgoFjCRTFHYVGC0ZTXtE63RddYDxRrVpOB6i+UMnQzPRXUtx3GqZrPqezwZDFsgy9J+K3HGW5KFU4E/BRGWFLRuhK+kWvgkB4kVXcggXwcOCjxKel1lVve+Arw3klw2eezK6wIQaS7SWPG1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NetKKcJK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee0b309adso386593966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738170316; x=1738775116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRowOtlKRVvp38uK4zXnKaXEy5jEK577Ja0lVdjBles=;
        b=NetKKcJK9T2AHBD06XIbdE5GWY+KYonllZfYf6SiBir4sxXsBrT0EsPlcRzR+4Vb6S
         Cf7Tk5a1/2hjnmfMlw/QBx16aW3ZbF0aoEHThPoa6VLOiwdN3Knh2NR0SgtFsUfZRsAT
         JDCOFR4C9F+zC1/Qlfj3Aq12NqbPwaUizvOVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170316; x=1738775116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRowOtlKRVvp38uK4zXnKaXEy5jEK577Ja0lVdjBles=;
        b=cqMXbM+xQpi4qRVcAtFjg23aVojRDQhNu4V/3+ds8ctvzpsmAsI+jqpvgKbKscTXqv
         9lwrgkbikbTEcL2KEIXM4tJZFo75yLAkgvo2EkTI6EmNHmd5g7ZCl9dtMouQHpD9jnsW
         W4TcOnhbDU95WDdMTykdn/AfDRyuSYKM1iYWVhIDoKMNQ7xbmQoquN8+9AQJ9Bv33a/j
         tznrVpQQ+dm4HC25TybvYGqmHSLM2ShNZVCOhqUDfGibFuSTTAPtvUPy99I11JSBcmMg
         nqYHSbCVoAvRJxoPPvF6nBUtM/ADBUxWZ1XoHytUCWUpqlAS4WhmQvotxdb+KT1FdW92
         iV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9w/D8bGNW/xeWfmJM/QOScJhqkgyexxtkrS6TpHd0YMhQ+f5VFNBeas7hd4hZRCkx3OwtU5WL8pBgNkXg@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7HfQZMILIdBh+XO+LZkrxnzzzILGlMHaG7lO95UQwoHC2wP7
	90LSXbW82ylCEx1Pqm6lnJp5xhnhbEVSFEZWpjlErxHxIvj0snoLsLs2TSBOcdYc1l8L9BnmY34
	eQdI=
X-Gm-Gg: ASbGnct2cyasH93CTW9pFmvthb7Ih8hzb9vVX9LStBF35UCqHSqcSf0FFuG/7LxhInF
	cjlO3wKUJzYXrps36W8lfG/arv84HM5Zq6v7T/iILxMEW5D/yRy5yhqSrJUuZpOwbnkVtfGmBZT
	Nc6XouG/GdaqohqJtx9PTmQVkMqxuKU0cHF6EjyLgek5m2PIVsRzQUn+gTPHJhXSVCiNxfBpeNQ
	+gavsLCavb3+Jn+VXcw1Y498oNK82WKkQQD6Y7nR7yoJOqDLmMFbE9qYqah2ccLcwrBGXnEV/VI
	A5+/RNvbpNxYeU82epfoelrioOGp29qjrmYcePJL/9suDsB9XAUYJL8j4cweeldf8Q==
X-Google-Smtp-Source: AGHT+IH9PX9MuKSm7QYPzolNt7FJGKkSuCHUT2a3ovK5/1Q0/ziBjQ/Rtl8vcof1ihSIQG57WMy9wg==
X-Received: by 2002:a17:907:2d8c:b0:aa6:5201:7ae3 with SMTP id a640c23a62f3a-ab6cfdbbc25mr397353866b.40.1738170316029;
        Wed, 29 Jan 2025 09:05:16 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab237sm986318966b.120.2025.01.29.09.05.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:05:15 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaee0b309adso386588766b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 09:05:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRrpxoX1a4IqtZZUBPDp2CsRDLwNqOpxXq0rNTok6D3yJBAcNlLUw08ezAl/hspOUS3S53yQd0QBPajI0N@vger.kernel.org
X-Received: by 2002:a17:906:a3d3:b0:ab6:d9f7:fd71 with SMTP id
 a640c23a62f3a-ab6d9f83783mr173530066b.51.1738170314791; Wed, 29 Jan 2025
 09:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129063757.778827-1-hch@lst.de>
In-Reply-To: <20250129063757.778827-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jan 2025 09:04:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEWCChmYPWd_EPOOF7m+JZoRnEocmjj5sPptptc3AwYw@mail.gmail.com>
X-Gm-Features: AWEUYZmwC1Ald9WqBF-Cp_KN0JvExAOdAcs4cXM5XixwhG0EIDgjw-cpPqX7yFw
Message-ID: <CAHk-=wjEWCChmYPWd_EPOOF7m+JZoRnEocmjj5sPptptc3AwYw@mail.gmail.com>
Subject: Re: [PATCH] fs: pack struct kstat better
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 22:38, Christoph Hellwig <hch@lst.de> wrote:
>
> Move the change_cookie and subvol up to avoid two 4 byte holes.

I applied this directly to my tree since I was the one asking for this change.

         Linus

