Return-Path: <linux-fsdevel+bounces-44458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E985A6949B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4B5887EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE781DE3C8;
	Wed, 19 Mar 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptyzxz3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E023CB;
	Wed, 19 Mar 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400983; cv=none; b=AlDcEzXZIWfAt9DWZemTftV0G2OWHNVSPkiEm/nik/ilISf5bxyfwTFLJvVBeM1QubpUz1PSZYeree+sXHwdWY65PEJ20sZhJW16cdcnqK6IyO5Md3NiFb4EhBUqAJfi7FlqYaWbj8PtAKMQcwycKX7LnVMdKnDLxGfefXgzDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400983; c=relaxed/simple;
	bh=iLAKgtJ3jR8xLo9vXep9+AgZ9X21bYFNVeCOFKNdBoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP8KXG0aVqy9VvXRE/COHg6xsso4oIOunnueZMztpAKdICBAXJsQD9fnXHb5n7XZjkb01UzD3KQapWyIq3CbHn0wAdHk+XPUFtQ04DoLof5ckvXQC8pv87H8mDQ7NFoV02Jrd07R3nD45n9awgfKdj3iAVBD6oyH9G3dnVgqGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptyzxz3g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so47953055e9.3;
        Wed, 19 Mar 2025 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400980; x=1743005780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLAKgtJ3jR8xLo9vXep9+AgZ9X21bYFNVeCOFKNdBoU=;
        b=Ptyzxz3gUpi7Y21N46C8OMzObFDC6BVe+tD5mgeUwikPsUhTcgcqmJXoXwuXI6KabZ
         2g844MUkO+DMYJldJ1Y9TXoYt5uWC++O8c8/egzXhO3dGC1L/KQEL3eYLEwRnpI817WL
         zzQVd2qAVIScgfTWl0ARGNfY/7O1MTo1qacxFSThCtbA+M6ookX/KUTHm/RW82cck92g
         iEJqFdQ12tcETrDu6MKsuvTpLqD+pGmwS1YIcMwoeZYDVwBGwqmq96FzF1Fw0adut0y1
         2EvXgKw2wuGdO2rTpGEAQ+CKgFTvC2LgsNcaHVZD9T0mPnJmx7zD9LmoWU30FTejfjHu
         O4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400980; x=1743005780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLAKgtJ3jR8xLo9vXep9+AgZ9X21bYFNVeCOFKNdBoU=;
        b=akoFh0Jbd+wkZLLJ7Wu2So8YK1zvaeclx6k4nGKucxNI9H3h7fPOTV1Xwfv1tNqy4n
         7bMjNuqsMrnIAG21t3zm9eNE8S+SNO3o1t8Pesyb3ZBph4hrH6zSJf3TK6W+BP/t4GZ7
         vnrnx/vOIYBa482Tg1gSowd/9hf+ydQdkoKR6OVjfHRHMpgPnBllbDrG9h4y6or5X9SP
         xejH/FO3pQLm8ZFGNsbG1b9P9SfNzz/p+GWcbhky1DlD+iTjSr9+/lxlnkSM27MPiGXJ
         gR803+Pk22vdVDquIldfHA2QBQWUfHhrfAwAWxQ3J3P8aCdvCuj3103hj8gCblJ3pZVO
         lXHw==
X-Forwarded-Encrypted: i=1; AJvYcCVEeA7STZBDb70pgolApWu7noEpbOthlVWz+wrk4SE+Lq4fKscYbM8O/vgyar9pSnsn/aX9pF70H2EZMkG/@vger.kernel.org, AJvYcCVyO8SRwMi7N3xxOHe+XH+EPdh+D/i3+QiJXyKOwv6Udip4Je7TVIlRz634VY10P8Bm6ekSx9zHvEcu6m+z@vger.kernel.org
X-Gm-Message-State: AOJu0YySEjYeqrh02ny/H1Yn4jMS3A4Zkd04alUOGwDB+ERNBJmVixNN
	ZZKF5nRD7AOj8HWFybuSXpWhq46LpNvOR6nUsg49po13oTdxuzCLNRElexGLRZejhm5hxTgNuPX
	gVhIaqT9kWyUyy8le+EGLWRFXDZXYJtzN
X-Gm-Gg: ASbGncvpNlsY2jO5sADlI/56qVKZlc/RO/9h+wrIGhcAgYYA8baquNI+RPyNFiPRjgk
	8gvNI4kCK4NZyX2Ffuk7QML4t/3IWytYZlk6sJuAsYSX4sf2+bQIMhNHkeM2eUh7DTk5DjI8TgK
	J8VlUs1xRhONTN21+vzdTqodLLxQ==
X-Google-Smtp-Source: AGHT+IG+n+cZPten/10NYAh8jH1fbHE7oczk0vs4b1zjbB+QtZHfAI2z1bxudf+pQqHrndbQChBeu6DNsxIcM/eCXQA=
X-Received: by 2002:a05:6000:188b:b0:391:4940:45c3 with SMTP id
 ffacd0b85a97d-39973b2b8e0mr3254066f8f.54.1742400979785; Wed, 19 Mar 2025
 09:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319004635.1820589-1-mjguzik@gmail.com> <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>
In-Reply-To: <nb5g34ehva6wmjusa3tin3wbsr26gm6shvuxfspzkwpor6edxk@ncx2um24ipwq>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Mar 2025 17:16:06 +0100
X-Gm-Features: AQ5f1Jo1yFZkSVMJxnOVF73IxQys5ca94rGOBsTEBHhcqD8i9n3Bmf9Quwb717c
Message-ID: <CAGudoHGN8ZKGCQCARU3kxX2XTk=LJE-AVGzPjYcQTjLcbCwqrA@mail.gmail.com>
Subject: Re: [PATCH] fs: load the ->i_sb pointer once in inode_sb_list_{add,del}
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 19-03-25 01:46:35, Mateusz Guzik wrote:
> > While this may sound like a pedantic clean up, it does in fact impact
> > code generation -- the patched add routine is slightly smaller.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> I'm surprised it matters for the compiler but as Christian wrote, why not=
.
> Feel free to add:
>

In stock code the fence in spin_lock forces the compiler to load
->i_sb again -- as far as it knows it could have changed.

On the other this patch forces the compiler to remember the value for
the same reason, which turns out to produce less code.

--=20
Mateusz Guzik <mjguzik gmail.com>

