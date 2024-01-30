Return-Path: <linux-fsdevel+bounces-9546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675A8429B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E152C1F29585
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC861292DE;
	Tue, 30 Jan 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rnv5mQK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612491272C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632886; cv=none; b=pto0YaUD1YrBBqXYCXlovF3FVjHSwmPaWpSGfKTByVNk3FO2N1KtfXauKhdF4aC8/6e5m51/B0uXg3xE5LBNiomcgwR6tHHhmaiwpcVe5anW/Wr+dEezcdzNmxCO4gSIbn7DuDlngfTNPbTGib0JNzdhWUw4EdIPIfyT62RwSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632886; c=relaxed/simple;
	bh=xjzjJrysSvPLCMEzQXvZ+Yu3MMpIhvxElmjRfyJJaJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFno38FmstpE2jPkEOG0kHUjir1qArCeMBjeO7XqxLffUEesgvg0wAogZ3vEA1OKAanHrMbtN5NUWRkwZmROViKCuDq9bps0Cx9dDffVIxeyW0BmNyyxDDz5DAwd3odebI3jjwNuMs53e4Fe4nRcz3kkFQDZr5GhKUWmahMWVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rnv5mQK+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8d08f9454so186935ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706632884; x=1707237684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=Rnv5mQK+13y3Kl63A+LOfoOxgsjsI1Jg73ay9+dxz96LQltsee/IrGbdPT/Hzi6KXR
         SAtUVhKthkuQ3Uh1SPSw+Udj1dlw3tOHUyXwJWUORInjw5ybXUocNYJILVGCVTa2AOMj
         NLgH8b+bXkX7U3oib44AUvOrQzwS+xEIIVGFEWyDqxinLBbTglHSe5d/uDvGURaGSQjy
         2icXmugdw7SgCazZ3UwMvU7xJuaBeeyRMpNz1Iqv7n4JbxRovlKM92PGDUML/eIimgoq
         9RZwyRFeHUEAOwrOm0ZTWArHnsjwNgUbLjaWQy1CZRr/7yXa6EuOS7RJQrA7nt9K3Hbc
         px1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632884; x=1707237684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90dsUhogDic1HENZzxBxVkMyjCg4enXsEvtqV/HnIcY=;
        b=e+Lhs74WRLL7jOlotCL4uoBvGETc0AKCjal2XeYHiD5QvpxHNc/ggpLReD2lNr4coq
         28iFAIUFql/IoIowbjE2/2JkgDUA0Oj6ytuqAUtfE5QeE8zRQA43I7TFVXyWnDomxnl6
         2K7ngOXin1xqglRs+0cospfM3cqBFdGWrcOsiBodACwcdxZI2qwUn8DYbAoExzwpEiyi
         HWQprpzBmKPIkgnuHxgSKEByuksp3ga77zP1fcTGZwgy04B4PlevKFJvWIXlbKnWdjJg
         Sk8PyysA/tcfjk522ad5vbgJIwNERe4bumTpkTC1unhc5AEQjbVWUO7c0YWr6KLyjwf9
         JgGg==
X-Gm-Message-State: AOJu0YwVCKKZPfjIGvS3e0xYcWNzKT63Zbj1TyjJYxDRhHHMlcEZDv2v
	YEmcUKomuF6f/Oo5qSZQPRghUA2x+0uZQOhCq9th0ggRzgfY/3wQu5BLdlr/HKiKUzD+LgMP2qi
	ulq9V74zDm6nL/FIusb1Mx1iO8pHbr0P+6byD
X-Google-Smtp-Source: AGHT+IHIP7C3utp4fY/dALdbVUWF+osAYCzO9ppmlrDUJjiU1ke2Swm5Kxm7V+pizKtZTAN6z4eEbMWQ0Gqqu4lSIek=
X-Received: by 2002:a17:902:dccd:b0:1d3:7db1:388b with SMTP id
 t13-20020a170902dccd00b001d37db1388bmr233504pll.11.1706632884096; Tue, 30 Jan
 2024 08:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ee5c6c060fd59890@google.com> <20240126142335.6a01b39f@kernel.org>
In-Reply-To: <20240126142335.6a01b39f@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 30 Jan 2024 17:41:12 +0100
Message-ID: <CANp29Y65E_jqfhkipGzJQ5DuDhpZzLrNJmL=foAgk9cgD8L5tw@mail.gmail.com>
Subject: Re: [syzbot] [net?] [v9fs?] WARNING: refcount bug in p9_req_put (3)
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending the same reply in plaintext]

Hi!

Thanks for reminding me. I've just regenerated the list of
classification rules based on the latest linux-next[1], syzbot will
reclassify all findings once the PR is merged.

[1] https://github.com/google/syzkaller/pull/4471

--=20
Aleksandr


On Fri, Jan 26, 2024 at 11:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 26 Jan 2024 01:05:28 -0800 syzbot wrote:
> > HEAD commit:    4fbbed787267 Merge tag 'timers-core-2024-01-21' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11bfbdc7e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4059ab9bf06=
b6ceb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd99d2414db661=
71fccbb
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > userspace arch: i386
>
> Hi Aleksandr,
>
> we did add a X: net/9p entry to MAINTAINERS back in November [1]
> but looks like 9p still gets counted as networking. Is it going
> to peter out over time or something's not parsing things right?
>
> [1]
> https://lore.kernel.org/all/CANp29Y77rtNrUgQA9HKcB3=3Dbt8FrhbqUSnbZJi3_OG=
mTpSda6A@mail.gmail.com/

