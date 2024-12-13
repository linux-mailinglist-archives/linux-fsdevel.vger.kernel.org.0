Return-Path: <linux-fsdevel+bounces-37342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD29F11D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A5D169E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6061E3791;
	Fri, 13 Dec 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TKeTgPg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39F1E3776
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106424; cv=none; b=rIFCs9AHx08VTBENOPZExoqKcXsmkx1oKWKxdNEjFz40BW/czQvLmvZ2Sd5+9SGDmAN0aeoMJsmRvpBdpuAgmTsyzRhUNHPXM/EWPi/oLgp7w98JAWJNXoHLNcj+q8sRb7s2xihziWnuQLttobI4ax0o6XPjslG5Jo3VFYqfwP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106424; c=relaxed/simple;
	bh=JeYzecM4Ws6DAx8d1eYSSaAR9Hxv7aMjtxrtoNso9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmNF9A3qY+Wv8WFZXrdXn4DtSTpd+EFFdbiW511cKJdXinlgXGGS6unOrgK1sAm3yvjV4n0sYmUzHMr8LuuLBk7LkiHw/gdfEr1lY9l4GLXJbiGuP0akyQwzovtW3vv/PehsGuy2n6liopzRbZgCLziWhlv+LYvnJXPLr2wt5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TKeTgPg/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a8d2d7f1so5679431cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734106422; x=1734711222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTgK8vtVJlVpnYOvWfFrTdJyV8eieOKxBt4m4Ra+gVk=;
        b=TKeTgPg/8oX2Y8pKOxSAhgWEVJyaC7KXrxjWYmWXcl3JKMZANV/WjvW4NKHmRYLidr
         HASKJutne3XwWfzPDHpjnol7Yh38IYPnXunHlrkBL9yqf96DSF5lKh8zdX7xqJPbFEEd
         5Brt7I+JN7Dd3sZ7fce9mnPYFpvAhT0N7ad/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734106422; x=1734711222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTgK8vtVJlVpnYOvWfFrTdJyV8eieOKxBt4m4Ra+gVk=;
        b=d/mWzla2wW3ljzoxWzhndplX3GN0seXoQM7L+uZ9RiBNOY8AoMvLxRSPriyK9hIcjt
         Oq9XgnehxmShgn7swgwytazbqSKXRkErTvOFKoVfTXRbZH1GwPEufBYUQwSLnddxb6ON
         tUlhh9+vSQqFsVJXQ+XN+7j86DtwnNf/PInD/9RMvoVhsZBQ+jjVDZiORP0lubpcGssm
         vfCQhmFyOADYfMtrqXoakf7q2/OuKN4Hn19bs4ti8LChVfH3XEcAWrgouUlwEAPOd4K1
         9ZeZDwZ2paXtxZFyUIRJA5qFdgAudYc98xSWM8VcoH6GO5lRKTqHvdCvfeFeKzpfDiSd
         19dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtUTvlDKxFvAtfm9AfvqQi9arUXbY6ri181LvNAiq38LxDTKWP1f7aHwPksHKL1gChGss5OT1NExQdX55W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4m9R+K3R2JhA/5pNZ+OciGgNLG1ZBL6snc1VBHHD/Cgpau9J7
	MuKRwcCMOJlyOMfgFaI2Aswp6fhkU7id3hsQgAf5Xpq9YlQW/s52prhKIl8CwGRZ8t/ZdAGHGyL
	ASwYeMBZyJuSwbBSGd1+2u05X/Htf5Qz2BxB5jQ==
X-Gm-Gg: ASbGncvH/majwBYlW4xcpKP8MImUPQT4IOPrUlzqnwstDFwEeqA0BdL6GEFyypxZvNe
	Tzsf9xiuPPb+GCsJ24dkql2074INyrxRIYV8QyA==
X-Google-Smtp-Source: AGHT+IEK7cPvoYZztp8WXRex5AggE+7kQWRBIjyrSu0/57plBJrXdZPJ6JJi38gMdr7TZFixPLtwoFF69xUnqROniPs=
X-Received: by 2002:a05:622a:58d:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-467a582f1famr58994161cf.43.1734106421923; Fri, 13 Dec 2024
 08:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202093943.227786-1-dmantipov@yandex.ru> <1100513.1733306199@warthog.procyon.org.uk>
 <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com> <4b9f34f5-7cfc-40e2-b2a7-ad69d1d81437@fastmail.fm>
In-Reply-To: <4b9f34f5-7cfc-40e2-b2a7-ad69d1d81437@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 Dec 2024 17:13:31 +0100
Message-ID: <CAJfpegtvJr7zKShpFGtFUT66+2gz8H6Js9srhpaqUhXA6061BQ@mail.gmail.com>
Subject: Re: syzbot program that crashes netfslib can also crash fuse
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Howells <dhowells@redhat.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 13:41, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> I had already posted a patch on Monday.
>
> https://lore.kernel.org/r/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com

Sorry, missed that.  Applied your version with the above test-by's added.

> @David, is that the same sysbot report or another one?

It's a different one, assigned to netfs, not fuse.

Thanks,
Miklos

