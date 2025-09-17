Return-Path: <linux-fsdevel+bounces-61931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23AB7F3DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438E3481B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914A2EC0B6;
	Wed, 17 Sep 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afT0B43C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3C1A76BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115409; cv=none; b=uNbDQs5Lv62OR/Pl9t4cmtEYmD243n9+ehqltUguTrlLGDrCemjn6XIzPvA/kY0EiIfwuRi5XW8AxHXAGeCKd7x1ghz8f7GdEqTH2AEUDI3a8LNWrJRCd+aING9ZZX4J1ode6Hj5EThRW7GGfgcSgFHuqptIAqcIAO9omhoOKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115409; c=relaxed/simple;
	bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUPq9I9BtOQY0/JvJB/XVyun3WLIsbryQY3y15fxK0RRxVQOUKakFo3qUt77P3+6OZhSG4ZBr66A2UsRRIsV/jV5H3k9a1RAqRGH0okT11CVvprNqxlxCIlO6sdKKRUKuglW6Eoyman3A0CiUoDzXkXYkbYU3oTl8KnDyVcKpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=afT0B43C; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04ba58a84fso917826966b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758115406; x=1758720206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=afT0B43CvjU8mP41nVb7aQ4/cWPF8eoH5vQ2co/TkR8VIt5m2LJr1KcxXLc7y9A9lz
         xULcQEjfwW/IE0p0nE+FooBcuWtKoWqw11cUtfZHGQf8MZbui4Vm0lRNoKzMRHEdC8Md
         IgBTPi0tXqSkSEcoHy4nBWDHhesEk3SdvZg015+EFZyn/ErE4lkQYlet0E/ACXdyiZse
         82uKO3P88/Yvk6DX4UCScmcZIZpQEZdMhTlXtxUNHE+Hw7+s4upz6v/KPzgfq0AgG85C
         Dnq1aywf5AJy9ZxA7CcPFJT+egOYj5ZAzKB8AC71bO6CjeDQdVgMOKvXbs6mSpHY/3tg
         JQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115406; x=1758720206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=jU5M+ChWXJw87LYxH+/JgpF/1b1Q5ZJmIx3w4IpheVQ6LNTu4Uvj/lwzyUGjV/rc7q
         5cQl8zWoct09H1CxNWGATi7Ar7W/WUUCzgE4ETE/yAAGq0aN0LDz3QDdW3OKqutWViND
         ehVF8D6+5BPcqd/3/UEqlBwYb+cmsWz5NsxFYRxnt8h81l6rS1idwELmaGxpZM+g7a3r
         4CtMhOaxMaYETslMDO3y/eFukaF8E4c1BuIJ8oQXRLb8s2qMhdsjBhJVOoGzluqAXr5w
         2K8kn0hEZP5EEyKK66cAS9gGoJ5O8w3hJy2wx+JbbI24z8s1pMzGN9KDT8002B+8w0t5
         QjGw==
X-Forwarded-Encrypted: i=1; AJvYcCXaUv/H5s+iJgd5Jmc6fvkCCKDne4COFFsks83MUEozWbk6y66tpsKfYVmViZa6gWhY+3tOhcGbIcK0Lmgj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc30Rg00gOmac1fusyS26r9bo2AUkNlEY7CwpH9yEjGfiozkTj
	Hk8n+tbHg/pOsq5rndwSQAUQmBZMOb42CPjVglPsWMR1SRASLHIE66V62va0po+JdDHoZ2XLDQ9
	Pn99sBdppQlTl04H6jWfDT+4cqlj2km9wPDui9Dg82A==
X-Gm-Gg: ASbGnct55co66Q7b204wN3Qr5mjm/Oqu8hmYEO/1OuzfvlwdMNsGgWrTTUlTpWrOQ0R
	N3GFHdmdponQ1KTblXcOJeLF1uRBG1Dd1CWrYj96u52IlinwRHARmFnpznl/Dc585bxXmnD3eVe
	eAmBjiOEd1cu02wjE4rIy6quuddC/F/xgUJYhrJxFAguEWMAecJzP14urJEPd7lTDwGao5ESiHR
	qttDe1gPO47/QJA4ASINQMT0whDpBkM+m++/99wUUEG8Qw=
X-Google-Smtp-Source: AGHT+IEgewShkTB3IO6iy5D1trv7nKdXbV9WtwtBpgyTEh9TZKuca5Qb4ed3HJ87AvQ3ZW2yo7J0WCyjmW8j05mLxIk=
X-Received: by 2002:a17:906:7309:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b1bc1ed67femr266992466b.54.1758115405633; Wed, 17 Sep 2025
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:23:14 +0200
X-Gm-Features: AS18NWBL5l4pIlkCFqkI5FbYZctT10PlbPlrGgAIhMPZCsLLpTd8MK5AI9j4JqQ
Message-ID: <CAKPOu+_EMyw-90fvNXXRHFpbi8FDc=fd1kGs21iE9+M4ZZSWeQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Given that this is a reliability fix I would forego optimizations of the =
sort.

Thanks, good catch - I guess I was trying to be too clever. I'll
remove the "n" parameter and just do atomic_add_unless(), like btrfs
does. That makes sure 0 is never hit by my own code.

