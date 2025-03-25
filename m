Return-Path: <linux-fsdevel+bounces-45011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C59CA7020A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2A7AB3D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF65256C70;
	Tue, 25 Mar 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4xQoRfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789C1DFF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908942; cv=none; b=D0FmZ6juCF5v8wRBT67NU8NqPMZM2U5UiAs10T7k6vBk4vtpwwVEX3MiXyUjzQzH04YeVcQlf4Sm2mKeogyxu5zZzTdy8radTCuNUdyB9XL6jrfPCtWgfxv+NPnv4lmZAX+oD0AX5yQJ0vvbgbjN2/laX88eSNRoUrGDR9bBK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908942; c=relaxed/simple;
	bh=NLIj4DqkfV91QAqXWtee8buvtWOxebZLCRdXhIJFEJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCjujEJeOJ0qfG9IWqsdSgNnpl8kcsQJMVNtb9blwcm29WpEmXdDIQRx8mk02CFCctNHki1SsN3OpH+k5+PknFadEK7e5Iji/pL9jkc9z0KSHV82EpXm92TQKo//KsU/FDDwMwzTTaWAbu+OPDuKSmG90g7daTOK8KoSmumvMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4xQoRfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742908939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLIj4DqkfV91QAqXWtee8buvtWOxebZLCRdXhIJFEJs=;
	b=a4xQoRfJEvFzBP7CbMH5AslvKLfj4ShWfLoVK5vLtNy7kdtHBOx2RWOCaGt7Reqrog5odb
	Y7cKHPv6TGZhFi8qEUfehcCP3dpt1jgyA3k1GLOkh3ci33yXFNsvBmo0zQNq3k5OymJtq2
	z01B2v2Eirt18IphTx+0oTXn5JgvKFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-U2BTqdxPP0mrqP6NVdo4mg-1; Tue,
 25 Mar 2025 09:22:18 -0400
X-MC-Unique: U2BTqdxPP0mrqP6NVdo4mg-1
X-Mimecast-MFC-AGG-ID: U2BTqdxPP0mrqP6NVdo4mg_1742908936
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5B371830305;
	Tue, 25 Mar 2025 13:22:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F3ADF195609D;
	Tue, 25 Mar 2025 13:22:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 14:21:41 +0100 (CET)
Date: Tue, 25 Mar 2025 14:21:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250325132136.GB7904@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
 <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
 <20250325100936.GC29185@redhat.com>
 <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/25, Mateusz Guzik wrote:
>
> On Tue, Mar 25, 2025 at 11:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 03/24, Mateusz Guzik wrote:
> > >
> > > On Mon, Mar 24, 2025 at 7:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > So to me it would be better to have the trivial fix for stable,
> > > > exactly because it is trivially backportable. Then cleanup/simplify
> > > > this logic on top of it.
> > >
> > > So I got myself a crap testcase with a CLONE_FS'ed task which can
> > > execve and sanity-checked that suid is indeed not honored as expected.
> >
> > So you mean my patch can't fix the problem?
>
> No, I think the patch works.
>
> I am saying the current scheme is avoidably hard to reason about.

Ah, OK, thanks. Then I still think it makes more sense to do the
cleanups you propose on top of this fix.

But I leave this to you and other fs/ maintainers.

Oleg.


