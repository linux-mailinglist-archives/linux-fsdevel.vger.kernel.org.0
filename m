Return-Path: <linux-fsdevel+bounces-13290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7794386E348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2C61F223E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB72B6F510;
	Fri,  1 Mar 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ylv4V3O9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD96CDAF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303112; cv=none; b=cubzfJG1BkjzCqapZx1rZ3JR8Gowk0nDfebtZfAuNxeoNSrBbCAcncAMl9u4Fe5IVxyYU/Pa1NiXIn62eGoLDxHnNCZmKImklbqwH/Iff9F88EQSy5LZeh5euyW3KeSJugI2/r/5ZAPn7J17XgCuZktCwI8f9cxxnECt/JLNj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303112; c=relaxed/simple;
	bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diIYHyO2SOmSw29lpmZV1Odjv0MBr+q/nm2tplY9o4IG75nHY/5RF5u50nKcpF7sBsJXFCmFyXSW/375d9F3afrpwDfxx+vOYlXxkwnZToTHnDoyQZ2la4vLovkwmL03xsyvv56nSCFX55Pe8OkrFvHolPdIGQhEGyzRd0N21v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ylv4V3O9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-566e1e94b47so714829a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709303109; x=1709907909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=Ylv4V3O9EYgKpUfFEacjXsPQpkzJ35hWPBK7pyBIomPjEz3ql96c+ZlvuhQg2s+Mi8
         FrMblwjAAyuOAFngXtJYe6F6bPkO708xXWdB25TxYa3ndZlHVHrYpfJUw6lK6p92cgrP
         RLKfJVRg2R1q5RgvLxV4wi1HqIEiEuWzmQJtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303109; x=1709907909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=gZnhxkx1KDo5kfQkZ6dLqDCYmrrYbllBbhG3c4eyZ7hRxPKbKlT/QOyDBiMHcZ4tXB
         A9ZIxISRBqrFu0ho524wyOPnSAhipSpbkwVolyZMdl8jo5xdhjLxMGnzByXDB51vwzsP
         r67uTxq0LmcDg133sH2cDbzV5GVfTUEhwfCEll54AimCMJ+e6zgn/VlLFD+evdBVzXBb
         eIaQJ+/jpVowuWIsiZOafqI8p5S7fyFD1OHjb/q1iPNBFhosXw3Gue6rnz2N8pZT6oqb
         49QjzALtEdaN0uU5Ln3dJquD2ShgRifhpxpXNptD6I6lTmM7os0BI5lfEIjrCzGoX74c
         CslA==
X-Gm-Message-State: AOJu0Yzr30VThRUW+flpPydpj8li4tpAJukj4rsSk/4KDfxTgJWWqn/z
	DQFv7HbhXpasjNaJjKpS+zM5+6ZZZE5xq++gIAlbxKXucgdeFHnKvxQeNl0yWZ4SQ5VOnXmBJt8
	NSgZIkumKm9rlOWEeN5uZ56/OkVzwc+owWRCagA==
X-Google-Smtp-Source: AGHT+IEhsrgq0r/5TG+8I3i+pYsCJeZ2wHcCwGUln1tbl6e7l4aRJSB0dinot2MdM9HMgBMP+IXw43g0gohie9KCMdg=
X-Received: by 2002:a17:906:5ad0:b0:a44:806f:ad56 with SMTP id
 x16-20020a1709065ad000b00a44806fad56mr1493961ejs.11.1709303109066; Fri, 01
 Mar 2024 06:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228144126.2864064-1-houtao@huaweicloud.com> <20240228144126.2864064-4-houtao@huaweicloud.com>
In-Reply-To: <20240228144126.2864064-4-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 15:24:57 +0100
Message-ID: <CAJfpegsSHfO6yMpNAxaZVMvLNub_Kv5rhZQaDuJHNgHpWhpteg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtiofs: factor out more common methods for argbuf
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:41, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Factor out more common methods for bounce buffer of fuse args:
>
> 1) virtio_fs_argbuf_setup_sg: set-up sgs for bounce buffer
> 2) virtio_fs_argbuf_copy_from_in_arg: copy each in-arg to bounce buffer
> 3) virtio_fs_argbuf_out_args_offset: calc the start offset of out-arg
> 4) virtio_fs_argbuf_copy_to_out_arg: copy bounce buffer to each out-arg
>
> These methods will be used to implement bounce buffer backed by
> scattered pages which are allocated separatedly.

Why is req->argbuf not changed to being typed?

Thanks,
Miklos

