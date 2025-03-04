Return-Path: <linux-fsdevel+bounces-43055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D60A4D8E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C93173519
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0D1FCFCB;
	Tue,  4 Mar 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="G8HhgLla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE91FCF44
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081061; cv=none; b=D3WwsMNkfCRMybhnh2SX8sEopLRn/szFbRfneQR+TxM+PJAFoLA835TVPGMfIukZEiRfc97+UQOMf8GirPmZ0/AjeGv7vrtDvgqP55stdPR0dQ9p87j2JerNhtbZP9s5HimtbuWFKbnItbOFLvq272MQaX5tE2tKZjBWYwQ+wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081061; c=relaxed/simple;
	bh=0Jdyw28ag/EkV/tyAMAxy1kQwRiQcwaztWAcRlzaG9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uT5fHRzw1hvYyXBmRddqSTTm94JCeE/XsMeEu/nPtPq5KIIITuu8g1teYGorTIUm5RMes+uzLziZK1SyFGDtPkWQpv8Y2SoJtCBmRaIfAyXAzfdRUAXnpjdqypa8L6Poh5uopTYZRs3FINFoXES/JrC/5lYoNEHdUUOiy9p9qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=G8HhgLla; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46fcbb96ba9so68374271cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741081056; x=1741685856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jdyw28ag/EkV/tyAMAxy1kQwRiQcwaztWAcRlzaG9w=;
        b=G8HhgLlaSPWUHmw3hSxq+VSkLzGnkNuHayeaSLIG2SW4AHvQNsuJFihyiX8WRy5EZb
         P+iH2OKnLsKDk/9Tl9rsQSjjOKF+YikeTEm1Ii3wkEV8AcgGwzTr7RCQ9KKM0kyrGKzs
         LBuuPnAmAFPran1ewdsoIqKqXNzX12wTVDnrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081056; x=1741685856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Jdyw28ag/EkV/tyAMAxy1kQwRiQcwaztWAcRlzaG9w=;
        b=aNwSIQfL0QS+3+y6KK5oK2OjgBywLe+CYTR6nlAFgdqAd7x3Myx6o66CkkekmhlvOx
         C/lpqHVdfWo+BoqSPbYXqNbzCelN4JCJBDZUN5OYKemzWW+UjHlcCfEZknneFen4VwYG
         S3XAHCNWsYlUsBCAMqOX0J90MBT3NC/O+TnMgQWWDR2Bn8smFszLn9SAX3mXbLaqePNI
         8UnBhdZCghpiCoiLGrAIjkiM63BdWg5Okl6PM5iw8YN9RdKzIFJbSkROx7H7tHNE7QQG
         JLZstYmO/c/ftrsk6tB8vn4LScbvnZtK02UxM9LmYA7cgGhmACZ/MUbmFaueOnxTcuXf
         YelA==
X-Forwarded-Encrypted: i=1; AJvYcCX4nb+ph2m8bkdQkVEuMuy5E9rZ4mneZ5jpzXYAaTWymFC5LHs4SXRKSdXg2+JkeCky2+rxA8Wt/1RbQgh8@vger.kernel.org
X-Gm-Message-State: AOJu0YwVANiSoIiDQDWOG0rKl5HUmKz3iSFzhFMz6lYvp4C5dCDzh3qs
	gUZVJ2nDPjUc5r1tOzvqofTFmtYkS2RCHvOwNlPX8xUG5JADL3s7uoylBi5eIYP3Oxf88t1UNJ+
	BoHYCehVw26KxsddBYzLlddBMSP8W5fxKWDS+yw==
X-Gm-Gg: ASbGnctYgJilRrEbbM9JloT9dd8X7rQodHOuF36yZ/dIGoAZYgoqFIayjvB4c6JAFtO
	acLy4ZXd6c3Ps3r/0wnzAwmhn7djmKgTa2wxV4B4nC14HidDVBeMJJQbwsIciMI6F6CtK0lrnh9
	AN++tUXeshfUq3gt7v7A4zXoox
X-Google-Smtp-Source: AGHT+IHIYI42ASXlKXn2mmxOw/03JnEW9+rqcxBqvi2TDt+NB6hH1Wv965XXlNzrFcUgu8eQu7pdXt0eB4W5SaetY0E=
X-Received: by 2002:a05:622a:189e:b0:475:5bd:e9a7 with SMTP id
 d75a77b69052e-47505bdf0aamr3135661cf.38.1741081056165; Tue, 04 Mar 2025
 01:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s>
 <CAJnrk1YnKH2Dh2eSHXd7G64h++Z0PnHW0GFb=C60qN8N1=k+aQ@mail.gmail.com>
 <CAJfpegsKpHgyKMMjuzm=sQ0sAj+Fg1ZLvvqMTuVWWVvKEOXiFQ@mail.gmail.com> <CAJnrk1YoA2QcuxvTdW=2P3ZRHGhWOYMOfXC=+i5fOY-71mBO6g@mail.gmail.com>
In-Reply-To: <CAJnrk1YoA2QcuxvTdW=2P3ZRHGhWOYMOfXC=+i5fOY-71mBO6g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Mar 2025 10:37:25 +0100
X-Gm-Features: AQ5f1JoXTW4GfDgby1jpRIsxTQ1PsYz2JWfkjyj9la7DwTkdH_Ud6Q6l4YK5B08
Message-ID: <CAJfpegsnSEtFVGnWjpM7pTMdCubuzenZqFRStteZBi3Q3+PWaA@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 23:43, Joanne Koong <joannelkoong@gmail.com> wrote:

> Will the 2nd patch ("fuse: add default_request_timeout and
> max_request_timeout sysctls") also be re-applied? I'm only seeing the
> 1st patch (" fuse: add kernel-enforced timeout option for requests")
> in the for-next tree right now.

I wasn't paying proper attention, sorry.

Re-applied the second (modified) patch.

Thanks,
Miklos

