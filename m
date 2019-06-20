Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E24C65E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 06:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfFTEyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 00:54:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35959 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTEyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:54:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id t126so622769ywf.3;
        Wed, 19 Jun 2019 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MW/su+o+v6T2QvqNurMqmEV75+/lw0/F2WltmYliioY=;
        b=Ij5vc5EQe6TuQ/Qgy9n9DYJ7YL5mY/CwRppCFMX+ripR+JCHJLgDwvJvx8evQ+nj8l
         W4uQ7NQFBuq1mQA6QNQL3o1hC5tyeEF4eUNZzFSSaraeWShHJtP0rKljpypVW7BipLjH
         QRcbMdtMATD0//MxBrcQrxV47gJQ7iZyRHtWbduEGeRQ1jjtepPJ7yoxx1aLbduO1ebQ
         9Vq01EHi9WAbl3LT+gJFjFiS6pPZUe9tTT/yxiQJQx3SNNmSUq8/Owkxsx8wF/rs4O3J
         0qu0SP9qtw8clasOTYMeOd5Vgje9uB6A8NxLlRZbPcRhPjw93+mg1gBFcqzrZa+dRt3R
         PYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MW/su+o+v6T2QvqNurMqmEV75+/lw0/F2WltmYliioY=;
        b=qh/TjR4NyyLN98ZtRxvZ7tzCIdkRNfVSS3CmgqOcLHDfMFcxMJcTWOY5XxkXgt45Pi
         vp/i//DljGcbzNWEJuBcaKR0qJWv7upPnTt4Q/bHxr5/aSNz/waZlZ1UpsYU++phmd7o
         I+xE7aCAS8ahorwgVgubDGcHHKN4Ej5sN7QRw08tNqYDbE9FJJZVAoHjWoalMAlfuS1S
         VEWj5HLjnOYP7w+rOlAJd0xEJ1FJPbabJVZU17kRc2iWTNMXy3WiGFnOpbKxCtoQ7qLp
         jUq4aC1EewwEiUQfQZrm6DLMRcwLiyoAmRGmdJJoRULOWxhPwd+IfhSu7m2NGa6Bjnd0
         cXSg==
X-Gm-Message-State: APjAAAUDD2yKnlOclcGzDT1Jh8u822kd9sEmLF6SkJxODxBfzTUtv4oz
        gAN2lUpzPx3miODBfJxOCB3xukECqRXGU76Bw771p2sP
X-Google-Smtp-Source: APXvYqy2rK+hyU7hguWLx5KcbQPTkp92xKub1ixmVaXc9j4NT0mzvZWNapqiGllShOFv0/zWVAA2w4d1qEQuubOgfmE=
X-Received: by 2002:a0d:f5c4:: with SMTP id e187mr56869040ywf.88.1561006494419;
 Wed, 19 Jun 2019 21:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
 <CAN05THSoKCKCFXkzfSiKC0XUb3R1S3B9nc2b9B+8ksKDn+NE_A@mail.gmail.com>
 <CAH2r5mu0kZFhOyg3sXw6NVaAjyVGKuNdRGP=r_MoKqtJSqXJbw@mail.gmail.com> <CAN05THRq6CM-3ZHK5WNE-VA60N0MxSHTxeM7sp-hz-ehOTeEOA@mail.gmail.com>
In-Reply-To: <CAN05THRq6CM-3ZHK5WNE-VA60N0MxSHTxeM7sp-hz-ehOTeEOA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Jun 2019 07:54:42 +0300
Message-ID: <CAOQ4uxg8cz_0=5BaMAniD+50mbvrC7kbEsXhEe2oWKrXfecptg@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:28 AM ronnie sahlberg
<ronniesahlberg@gmail.com> wrote:
>
> Guess we need a fix to the man page.

You mean like this? ;-)
https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/


@@ -1546,6 +1547,14 @@ smb2_copychunk_range(const unsigned int xid,
        tcon = tlink_tcon(trgtfile->tlink);

        while (len > 0) {
+               if (src_off >= inode->i_size) {
+                       cifs_dbg(FYI, "nothing to do on copychunk\n");
+                       goto cchunk_out; /* nothing to do */
+               } else if (src_off + len > inode->i_size) {
+                       /* consider adding check to see if src oplocked */
+                       len = inode->i_size - src_off;
+                       cifs_dbg(FYI, "adjust copychunk len %lld less\n", len);
+               }
                pcchunk->SourceOffset = cpu_to_le64(src_off);
                pcchunk->TargetOffset = cpu_to_le64(dest_off);
                pcchunk->Length =

You can do this shortening before entering the while loop,
then you won't need to SMB2_request_res_key() from the server.
and certainly no need to do that in every loop iteration...

Thanks,
Amir.
