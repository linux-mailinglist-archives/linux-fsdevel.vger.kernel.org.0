Return-Path: <linux-fsdevel+bounces-36434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2679E3A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B293FB24C81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7D1B5EBC;
	Wed,  4 Dec 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WTpSOjX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE71AA1DF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316117; cv=none; b=LXuhKffMMHPpAcK2GueOdKcVZ20TTf3MZGoe8ruqtZOaQBQ05M5nnsfuMpcEyScxl5GFKOParUbEPU1n2SoMrOTZrPya8zz6zAKSNdmMFcXOFKjluulHtPPHpbGiOrTpTqZJEtMFBe+lTwI8JdYxbr1siLXnb+J/Lhq3Pjgj974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316117; c=relaxed/simple;
	bh=CA8V7r/HHu+tdRQoB5cE5pMef+kvwPPpVBvOxT59EbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF9l2vklZRzoNYTu1/ZIAynqymQYSmbH/KVUzBvEi2mXXBKaGSQPk2DMR9H4VmNR6A3EaS0RM4U/keOEpOEgesClWnU5BGH4dcTgIvLFhTc72ECOkLc6K0HNRz8PanmWMtaDw2s1Gh2Am0iJzBBHAiBn7KKit1ahc2+3smqqZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WTpSOjX1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-466929d6013so56370241cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733316113; x=1733920913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8llbzjZ//9+h5xfG8QfPKdjzTna7E693fwr0oTRJmW4=;
        b=WTpSOjX1E+ZjKOXwvnzsH4JYwoHZdu45yJWrADLItLOHgc4fK/oHYOiO0ACgTTF444
         QCdfACRXW86bKZljf6dfeHNJGn5jFOwqPPs7zcn14k83veQA4RtVLdjwAYX80fKfTyYo
         RiZruPL0MVg5lyz1dysA4SnTvQg9hAJfKP39s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316113; x=1733920913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8llbzjZ//9+h5xfG8QfPKdjzTna7E693fwr0oTRJmW4=;
        b=qYz/Wi5isOXNWatm9QdWF+/DPcQsQX46uJy93bpUiQDIkSA0e1FAqPW6BekshcFUB7
         PsDwo1YK2EUwILVTGmQ3gNKhLX8ocRTBWqt/tHl100JDGP4XNNAl7CEZzib9NcHbduuV
         YX9SjQJZcGn/wHp9ITFEjDQRxZgcEae8upSnvlqIjE7m1JISJ6mb1SgWZnrTvVWHiPKO
         cN8com+GFD/riVMK0n6WJ1qxIl7fbn4d+z789bHAdEmZktqEuWwQ4Bft2lZA4cVwiYR+
         HikCi9KGYPNtI5q00XdEm7l1OZJ7FSF3q1YjjJ4p8reXVouk2AbaMWy7UAHUoUTn5E8+
         BiJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtTvCRMt4lWwyWNWuZWIArRA2VKMTVnKGOjsx4tfIYEVhhVyHlP+vnMf5CNg5Cw6OJgxTbd9OCu5CSHDO7@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKeDLBaqhh/cgvEu5xebhhlPfgJcrkqi8ueKQNrSAy3SnlsDo
	NQvMiOfv7Ddt5Xas/3IStM3uiBz0nGfFnUD4BlF2VUvP4ge0MID4+YBTRiwwtVD8UsI+1/3t7pC
	/oixklAGFaD9s3kF0DmCInwBJsipluqq8nM11IA==
X-Gm-Gg: ASbGnctpG0uHjn5KNYf36Fmo5VcAkplp6+Y9Mb7VJXET0CM6YLW5JxFiaPJMnwwxLbo
	udky6XIQVcK5oZj8COTiRe88d/P/4EsE=
X-Google-Smtp-Source: AGHT+IFr6bGymy7YeT0tDLIC2vZBdlTOgMsR6dCpqF9+A8uFmv4A9jCBRMqqTxj1MwINnQpAGUucyxS8LL7NJH0OU2Q=
X-Received: by 2002:ac8:7d41:0:b0:466:949a:de53 with SMTP id
 d75a77b69052e-4670c75800emr96854181cf.56.1733316113334; Wed, 04 Dec 2024
 04:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202093943.227786-1-dmantipov@yandex.ru> <1100513.1733306199@warthog.procyon.org.uk>
In-Reply-To: <1100513.1733306199@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Dec 2024 13:41:42 +0100
Message-ID: <CAJfpeguAw2_3waLEGhPK-LZ_dFfOXO6bHGE=6Yo2xpyet6SYrA@mail.gmail.com>
Subject: Re: syzbot program that crashes netfslib can also crash fuse
To: David Howells <dhowells@redhat.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="0000000000003856770628711b29"

--0000000000003856770628711b29
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 10:56, David Howells <dhowells@redhat.com> wrote:
>
> Interesting...  The test program also causes fuse to oops (see attached) over
> without even getting to netfslib.  The BUG is in iov_iter_revert():
>
>         if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
>                 BUG(); /* We should never go beyond the start of the specified
>                         * range since we might then be straying into pages that
>                         * aren't pinned.
>                         */

Can you please test this?

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct
fuse_args_pages *ap, struct iov_iter *ii,
         */
        struct page **pages = kzalloc(max_pages * sizeof(struct page *),
                                      GFP_KERNEL);
-       if (!pages)
+       if (!pages) {
+               *nbytesp = 0;
                return -ENOMEM;
+       }

        while (nbytes < *nbytesp && nr_pages < max_pages) {
                unsigned nfolios, i;

(Also attaching patch without whitespace damage.)

Thanks,
Miklos

--0000000000003856770628711b29
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fix-fuse_get_user_pages-alloc-failure.patch"
Content-Disposition: attachment; 
	filename="fix-fuse_get_user_pages-alloc-failure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m49vmnzk0>
X-Attachment-Id: f_m49vmnzk0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggODhkMDk0
NmI1YmM5Li5iYzAxOWZhYzBiNTUgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xNTQxLDggKzE1NDEsMTAgQEAgc3RhdGljIGludCBmdXNlX2dldF91
c2VyX3BhZ2VzKHN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMgKmFwLCBzdHJ1Y3QgaW92X2l0ZXIgKmlp
LAogCSAqLwogCXN0cnVjdCBwYWdlICoqcGFnZXMgPSBremFsbG9jKG1heF9wYWdlcyAqIHNpemVv
ZihzdHJ1Y3QgcGFnZSAqKSwKIAkJCQkgICAgICBHRlBfS0VSTkVMKTsKLQlpZiAoIXBhZ2VzKQor
CWlmICghcGFnZXMpIHsKKwkJKm5ieXRlc3AgPSAwOwogCQlyZXR1cm4gLUVOT01FTTsKKwl9CiAK
IAl3aGlsZSAobmJ5dGVzIDwgKm5ieXRlc3AgJiYgbnJfcGFnZXMgPCBtYXhfcGFnZXMpIHsKIAkJ
dW5zaWduZWQgbmZvbGlvcywgaTsK
--0000000000003856770628711b29--

