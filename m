Return-Path: <linux-fsdevel+bounces-27847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568B9646EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75F2280E79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A11A7062;
	Thu, 29 Aug 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nBd6PJi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F81A38E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938771; cv=none; b=WbuVu5mmsxvHBMaGXGCaw4KT98bN1fgOgkXwHILd5FmUNl3OP83YGf7HR0T/a4klppZsDqDNH4OD2a7VvanX6QmtW0XtW7ZIdkUS2waV9GtYUWSZ8oy11pedI+FUvpaUe8a5lXogXg4e/31MY8l8SR+ofOPyJlHYyrkbyQgLnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938771; c=relaxed/simple;
	bh=XbO6aCMkO1kWZfw54jAVKPfoFGUZaX6GuCsC7Ff6HBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juiOOE8YfW7aSHEEa8+JkrtP1IUORpjvWzJmRPC6MmXsv4nYE7X5yqxlCjpp/ZzkxUfAihhnlFGJE55gFJRGlU1Rb5sakShQJXudAIyilcaBYrTmSzs20yBnf/uffrwNUR4VxW1f7JdGp0T3MnMOM4PD2hADzOUgnByv1Xx7Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nBd6PJi0; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso640268276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724938768; x=1725543568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u0Db+duZ1kCYbuwKPRDt6aZLvu8Z4lZPW5G0dyejLdw=;
        b=nBd6PJi0qwT3ePtAERLiX2VMRdhDWYQg5fFOgFcWvu6Oy4rP0+kcabfG+t3yOXazvn
         W3lFgP045JLtZP2ODDaNFgzDdoRmn5q3Hms9CBWp+FIlYmb7ViSRmEYEOmyJvU0LT365
         +oJW8DnT1LOFdxq4jTrqr1gZv0GRWVOBMnjmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938768; x=1725543568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0Db+duZ1kCYbuwKPRDt6aZLvu8Z4lZPW5G0dyejLdw=;
        b=c6qgxUe63mhisWpA1DnR/K3yuFsrf/q70iJvSxp4VwN3bHGNNll5DKmx5a5nU5yu9L
         MyQFMkqYMWNMQ2hVOhTuS3OXziyM181ZXicki9XiWHWWF+NrO9+OsKdbVYNZoLJJ36B7
         7JnNPCLvUSq9BCbLxvAZkJFT4uETyuowav3WCzPi4E3O8Jcy7JCrMiWUW3iu+mV/BAN3
         +8FSFrEeT42xhmFEu7tHIbxx0PBHxn71YkHaaBPLglYjkFAuP2KtLqW0HhzRbjmbKTU9
         WdEYxt+GbwB9BZJP2xQ+GqkPw6ZU10XSN2ahi+UEp29Da6xPgl6E43Bkq4DNrptAEse4
         MawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWemOVES1/BUySODBQgdivHKZyy/zyemStHeRKPhvskvCbABLSRylpYCg2bxR1ryXG6r3UVB5MKDwpQc48/@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnPyDdxYomuuv6K4t1pf8jvFxsblbWw33G09pROjntoRCvC1z
	ZAGYmqUh7dcSKMaNHzV4QcSnRnJKuwFft/UBXK19KgBXNDnoH2mmbHhyhQ7wBqscTOoqMKWiwrD
	TN6sEkW1avohpNCHQ/4tGLXrcYRYBE619z1SRuqSnGoT5Lrw2U8A=
X-Google-Smtp-Source: AGHT+IHknGOTOG6fcqmrcYLJ355XleJ/P6mCR3iaOZem2as02OkjCUyd3Mr6rcZYcK7Qyodzu15X0QaCkhAleChqhLg=
X-Received: by 2002:a05:6902:1b0c:b0:e16:6b7e:94b4 with SMTP id
 3f1490d57ef6-e1a5ac9a7f0mr3111925276.26.1724938768448; Thu, 29 Aug 2024
 06:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812161839.1961311-1-bschubert@ddn.com> <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com> <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
In-Reply-To: <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:39:16 +0200
Message-ID: <CAJfpegvOvv=LvjSoHJGSBr4_abh4DrP0=2=o6uovnvsUbzPJ8Q@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "joannelkoong@gmail.com" <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 15:05, Bernd Schubert <bschubert@ddn.com> wrote:
>
> On 8/29/24 14:46, Miklos Szeredi wrote:
> > On Mon, 12 Aug 2024 at 18:37, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Sorry, I had sent out the wrong/old patch file - it doesn't have one change
> >> (handling of already aligned buffers).
> >> Shall I sent v4? The correct version is below
> >>
> >> ---
> >>
> >> From: Bernd Schubert <bschubert@ddn.com>
> >> Date: Fri, 21 Jun 2024 11:51:23 +0200
> >> Subject: [PATCH v3] fuse: Allow page aligned writes
> >>
> >> Write IOs should be page aligned as fuse server
> >> might need to copy data to another buffer otherwise in
> >> order to fulfill network or device storage requirements.
> >
> > Okay.
> >
> > So why not align the buffer in userspace so the payload of the write
> > request lands on a page boundary?
> >
> > Just the case that you have noted in the fuse_copy_align() function.
>
> How would you do that with splice?

I would have thought that splice already honored page boundaries, but
maybe commit 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for
direct_io") broke something there.  Should be fixable easily without
need to change the interface, because splice is free to start a new
buffer at any point.

Thanks,
Miklos

