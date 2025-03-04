Return-Path: <linux-fsdevel+bounces-43117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D3A4E4F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF178A3CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0127814F;
	Tue,  4 Mar 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOUpH5lL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3D27605F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101556; cv=none; b=uNKjAQm842n1wD/K6wKapta9ouVnHKVWuapdjiVg7E43srQ9eYxi7jUf0VqcyQQfnswnqTUajFAAKA19HvPImKuyMlN0doIk4cERxi239DlQwwEkPFTLTQ2aV5BO2E75m/9Zod3NmFaIEQg5jC1BDWa8iT4dnLnbkqFhdBMOygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101556; c=relaxed/simple;
	bh=PvY7iupp/OELeEU1fL4FkgUAsKdFpjTPxjRFBe5QNyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lps06MXshc4b4SGZ3iKfVV4tfALbg2LSS2T9vTAUKSTTd2S25ke/jbyU2tgkdmGY28nIjw+ysi2Fye5ItONddWiENoQUgnEo6TftvBdSEObCA0VQyX7EMjJN9yD1DGPEb80B2L2rbxAEap1IsuIGQFWtesQvP/8N+Pzc37NA6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOUpH5lL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741101554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvY7iupp/OELeEU1fL4FkgUAsKdFpjTPxjRFBe5QNyw=;
	b=ZOUpH5lLFHCOKPas6wRyhwArx6RaQr8+5M26eSg3AbaCgwR/P6/vEEVjKfvDYXWD5+Mw2C
	8gMjcuMuydZz2DrJm9sdREHaT9K9rIwIDT1hfDZ1t6I6xAUFNfCUXcGMBJz5jLyAD38UT3
	lo/JteASwdbMFLVxNmso/ngHUJI1iEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-bC7wrayBNBqo0jzR62nHuQ-1; Tue,
 04 Mar 2025 10:19:09 -0500
X-MC-Unique: bC7wrayBNBqo0jzR62nHuQ-1
X-Mimecast-MFC-AGG-ID: bC7wrayBNBqo0jzR62nHuQ_1741101547
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 384CA180099D;
	Tue,  4 Mar 2025 15:19:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CA9591800352;
	Tue,  4 Mar 2025 15:19:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 16:18:37 +0100 (CET)
Date: Tue, 4 Mar 2025 16:18:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
Message-ID: <20250304151832.GA5756@redhat.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com>
 <CAGudoHG260oJkBPXwe13YqeC_si8RVUAHdMU1wMhNnXrZUFvPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHG260oJkBPXwe13YqeC_si8RVUAHdMU1wMhNnXrZUFvPQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Mateusz Guzik wrote:
>
> On Tue, Mar 4, 2025 at 3:08 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > It seems that we can also remove the unnecessary signal_pending()
> > check, but I need to recheck and we need to cleanup the poll_usage
> > logic first.
> >
> > This will also remove the unnecessary wakeups when the writer is
> > interrupted by signal/
> >
>
> There are many touch ups to do here, I don't have an opinion about this diff.

...

> Thus I would argue someone(tm) should do it in Linux, but I don't have
> immediate plans. Perhaps you would be happy to do it? :)

Probably. In any case this needs a separate patch, sorry for confusion.

Oleg.


