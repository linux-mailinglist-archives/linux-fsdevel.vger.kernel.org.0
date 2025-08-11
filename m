Return-Path: <linux-fsdevel+bounces-57432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2BB21720
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A207460A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BD2E2DF0;
	Mon, 11 Aug 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nywy5SmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B91F875A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946799; cv=none; b=UkEd+d8WU3u7oNXbqH6OXfx1Nab+EPFF1/qEnvrE1nXGHsCPIqbS8dEu+Lg6eG+lUq57S/mIPWiy+Wn4Xf6s3D2DrqBmZ6jZRiGZLIi3Vfow6Zep8X4LmLpNcn2/1AHZXPDg6BFzS/ZCLE5ns5BT9U2ivBjh+3hrZcnThYmiHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946799; c=relaxed/simple;
	bh=dEe7wfGl6fyDlPzqwmVaQAru0IA832d+a5Mkf8bnUqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9I1k1EF1yKqs19v8xhhMnnvIaRV22T1Je1arbDSJZn+WJa7yOjYv/D/PRg3PTq40dR377fNMw6XVKZIu+GAUYJm0+NsYf45LDt70oVJHtmapbgOcR4Eq5uwu+REoIiP1NVbOQKioNaySPoUkqEoGZns4UcnRrBRqUED7L8H2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nywy5SmZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b09db20abbso32184881cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946795; x=1755551595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEe7wfGl6fyDlPzqwmVaQAru0IA832d+a5Mkf8bnUqQ=;
        b=Nywy5SmZekRXd93hNX10A+2bPGyT5EVZj0y/TLr1qQQEBlUiQtvdfvQm6txBCTlp3q
         KUzY++kzjewGIJUFpujn9mozxP0ewigLwFvPsHIOvkhRKwx7aaSs0IRd9Lzz2tLCWIOR
         4kcoVynoAfXOaBC0ydaoajBzExCnu3vMB9AiyYHlQNa5/StyN7RNp7Pw9s4SucgY3fY1
         V06GzUjAWohwIlZuprylAAQJXCs5U2O2tiuuaf6JFrRrvm7UHpwB/n5tRRzWI8Dxt+bk
         gDiLj6Jifmpb3V8Bz0qR9u9r441TfTlvem6urR5DK5zpvVyl3NDKxW9z2Ngkr2Bws5ru
         xV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946795; x=1755551595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEe7wfGl6fyDlPzqwmVaQAru0IA832d+a5Mkf8bnUqQ=;
        b=DGOCw9nOdESpBa9HN0bUzfELq2UKEUe7gAj8IBPVrHBX/2TXOBPZas2KzLKFnNjCc9
         AgWYMo8zi7KllABRPb2lutKjDxc20ypU9K0OBjm2LqCtL3Yo8QlXkbSBg5itY2o82Aem
         pwWWpmxImaFhdQoFQoqOG5d+isKBHsEh/ezsakUQgM8Imtd+ecoIYnA3MWT3QjLyNnO0
         Xwz6JmkmsTbiruy1FFK7WXEW6lNZJ9I2DSY9RqIQimCrKmrF5W0fJbGNRYEkxTkeH2ba
         hnJsZ8aB6KW9zzeF8N0V6pbDgVytT4as6AJcCBgDKUM/ZX9wRka+LucNedlIPPbmf0Eh
         TvBA==
X-Gm-Message-State: AOJu0YxhMqV5B/UkTkhc1+UYQuzEgbkyFIAb8m6msLUf/6Fwfya6Ze31
	afax2ktpfBhjT/vWDkalRx18pTH0/T2qd/Wej6wUXOtbuEyEt5nP527gT0/vX6XnYbQjteKbmCd
	exQAC+DYNFCAT/AeCDuIMtcVdHUITJXk=
X-Gm-Gg: ASbGnct4VO2E/FIUg5bLNfq1lBl9e3oi9wB2CoOdtixAEcWx2ySZCasurN20MOO0Jp7
	CqaLQLfIe9pIPKVrRg5zpvDEmZpRCfButZPYOd3cbyf65L8jQijN8hRRpNKTV7fnaR5uO/Wm4qQ
	rZ0B1wx+8Wpzds4WYKHs3mFdqA7cjQwNOBQ1ssfYred0sE/53TvJKfaZtfrIE/zEgqhKgf4erWe
	EzCWaThskNTcyA6W1pVm24=
X-Google-Smtp-Source: AGHT+IEvKtuz4tBGEVjKduK9aRenneXd7bCgkDFjvsnCPghI+57/rBb7CjRXrACf6QX+Rnl/MbxgWriLa6/dllENlO8=
X-Received: by 2002:a05:622a:4208:b0:4af:af49:977f with SMTP id
 d75a77b69052e-4b0aedd9af1mr170403531cf.30.1754946794532; Mon, 11 Aug 2025
 14:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
In-Reply-To: <20250811204008.3269665-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 11 Aug 2025 14:13:03 -0700
X-Gm-Features: Ac12FXzOc8Kor11L0flkvrGoAnBMbxD_n5C1ROHYMlSLeMltovVL4WxqZX05Igk
Message-ID: <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:43=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Large folios are only enabled if the writeback cache isn't on.
> (Strictlimiting needs to be turned off if the writeback cache is used in
> conjunction with large folios, else this tanks performance.)

Some ideas for having this work with the writeback cache are
a) add a fuse sysctl sysadmins can set to turn off strictlimiting for
all fuse servers mounted after, in the kernel turn on large folios for
writeback if that sysctl is on
b) if the fuse server is privileged automatically turn off
strictlimiting and enable large folios for writeback

Any thoughts?


Thanks,
Joanne

