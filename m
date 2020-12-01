Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2542CAD86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgLAUjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbgLAUjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbKmbj2q3bXVVF2UGoGz1cN3aYCzV4bXk/zjzcW+Dng=;
        b=BUcQiWehgZB78fYeP2uVKlrFKQlvI2Pck1iDmVyyqkyrtqc3fYzDeNwxDFqDR9AhKATUnj
        Y24G3BR+onGbdu8rjWtptcAD+bef450vFagSuYbRmV02Ievusaht4Gsb4uMEoLtSPyKFM/
        yQkezs0ufMBa3jV0LYJSIx+z+URpnSo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-TDFf7P-AM26wPetyyDJLKQ-1; Tue, 01 Dec 2020 15:37:47 -0500
X-MC-Unique: TDFf7P-AM26wPetyyDJLKQ-1
Received: by mail-ed1-f70.google.com with SMTP id l24so1994553edt.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Dec 2020 12:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sbKmbj2q3bXVVF2UGoGz1cN3aYCzV4bXk/zjzcW+Dng=;
        b=alvelaRhTCAOUFu7imKQnWJptnT+/l0s5pfRdhb6EVctyxJ8Vi57DUteMekMdNihZ2
         yvH9QSV0uG4nmm62wNkoU1NxCvIn8eVajy+JC/y/4CWU2QPTmILaKwB+zOLW5T0WMvwk
         pna5sTAhwR8PpXF2aribHke1ykaf/POVlzMF/xF02CwwVspDziBouOstx8w+JUzcUjN5
         Ht3Kt7rk5hOrFSysJs/5vKo/kSHi2Xrec/4KTJ6WvTlMURfzluYf9pT4rbdt+79dV/w5
         YHdV7vBOA6O173hT9Pi7lhRZ5T3jbG14RbsWFhh6xQdxcaLFqylE36WUKF2Rx9aAA1eT
         usng==
X-Gm-Message-State: AOAM5302vFos1oDeDwpEIpbrA2W8UD5Od5IGlI6lmtOCSL1L1oToWdkB
        6G+7kKT+e1leCDLn7rw1W59/z5CHFlmt8VUf0SPEgSgoBFSxo2fEGG/I3cs/oMzNu/g4if/evm/
        UmC4MogsjeX0Qqjl8A4nScH4Prg==
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr4885645ejb.224.1606855066030;
        Tue, 01 Dec 2020 12:37:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6vxJmKHJ0YVxj6K63hN5ZVVl3SbRygXSOycPC+FEbzXuZ3rtlcfEyvNl8i5f5SUNgN2Hh0Q==
X-Received: by 2002:a17:906:cc9c:: with SMTP id oq28mr4885636ejb.224.1606855065895;
        Tue, 01 Dec 2020 12:37:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y14sm428849edi.16.2020.12.01.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:37:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 05B14182EF0; Tue,  1 Dec 2020 21:37:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>, asmadeus@codewreck.org
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: 9p: add generic splice_write file operation
In-Reply-To: <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
References: <20201201151658.GA13180@nautica>
 <1606837496-21717-1-git-send-email-asmadeus@codewreck.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 21:37:44 +0100
Message-ID: <87blfd1cvb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> The default splice operations got removed recently, add it back to 9p
> with iter_file_splice_write like many other filesystems do.
>
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit =
ops")
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

FWIW:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

