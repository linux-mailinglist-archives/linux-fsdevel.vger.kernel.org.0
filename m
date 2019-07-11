Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54465A36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfGKPQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 11:16:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfGKPQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:16:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so3188411plb.9;
        Thu, 11 Jul 2019 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6x7b8VajcF1DGZElO1FQVch8twXC3YkscWrtgn58UY8=;
        b=A5mxARREPEkiKsbxlHp+gfYMUQ6nJsUDXqeHSlHmKq4pp/M/ywFUqyeJEJxXQpsLms
         5Ldr5iiVCIyrbdXWwqbs07G/Cq8tAVKiSETXNajAVFqCxb0O1w9gnr9RA2bokGmG6AZr
         1qkz8vnfK4C59iUMTCTV90VqgmSSWR32h02BqNH0U6U5ffOCzZopi+0EuYJxMqONqgV/
         Z5PeaO3U1ncnxbL9X+3iod0JeAw4jZ/oTZUJh1ntv7qt8L431GAX4xny7tjp5Ry7ZdNT
         NTHy16YkadYlqAAULylQMdVAmGJgBgf89PBcATyFTHZp0eSvXwBfzIT5PIJTYA//pU89
         2ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6x7b8VajcF1DGZElO1FQVch8twXC3YkscWrtgn58UY8=;
        b=ZrrDFRCDJzzeOuHXeE9DcWqAaM6omUAPxmscraZ8E9Hq6wFeDZXVNdmwnuBEOGmcme
         7CfN46LGkyOYmk9Qc9KrkW0icfWi3ee8vFHysq9T7uSh35F3Y/9Zjb8rAT8ey3370LPp
         sKD2r+P07U4f5GgT0jlViipLxRavSC8ECtl4VngpMjA53OPlqHXbgBJZs67wxLC+zEkZ
         3XtMCMjgcI1hN3/tsglkJ4QDDLnrizdxL+yyZWpslrqNgQv8OcT2M6aIJPO4J3MyWz7R
         lozy44Ioyu7SAaSvqwetbOokD+RBmkITpvdYlGaeQDo3DFprwF1+mfmLCKpCaetKBfb9
         7S0Q==
X-Gm-Message-State: APjAAAUGCVN/J0DDiQ0TAdX5SFrWiDEIbnJaHAvUkPu9tH2Yc0A7T7En
        5MnzIQAyIRpSPPWv3MY/WmYB8aJNOsfcRXnWQq+UdJQu
X-Google-Smtp-Source: APXvYqx98rqgVyjHmH1F+2j2JGK+j/Ul+Qm3OthdCFiY7dv6BKzfiiOdtWg8KoDQoyJgxhlluB0WCps3D9b0Gi6duoI=
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr5344610plc.78.1562858174222;
 Thu, 11 Jul 2019 08:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
In-Reply-To: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 11 Jul 2019 10:16:03 -0500
Message-ID: <CAH2r5muC=cEH1u2L+UvSJ8vsrrQ2LV68yojgVYUAP7MDx3Y1Mw@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I noticed that the copy_file_range patches were merged (which is good)

On Wed, Jun 19, 2019 at 8:44 PM Steve French <smfrench@gmail.com> wrote:
>
> Patch attached fixes the case where copy_file_range over an SMB3 mount
> tries to go beyond the end of file of the source file.  This fixes
> xfstests generic/430 and generic/431
>
> Amir's patches had added a similar change in the VFS layer, but
> presumably harmless to have the check in cifs.ko as well to ensure
> that we don't try to copy beyond end of the source file (otherwise
> SMB3 servers will return an error on copychunk rather than doing the
> partial copy (up to end of the source file) that copy_file_range
> expects).
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
