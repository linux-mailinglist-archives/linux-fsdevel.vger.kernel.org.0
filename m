Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8C4C6DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFTFqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 01:46:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44716 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:46:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so900579plr.11;
        Wed, 19 Jun 2019 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xqza1RteE+yZnsf6TJJy8YfLugJSOmuDDR38PN1bfrc=;
        b=P14P/qz5XwxUgQH5ZKcLdhJIchj1Br+vuXZXjsECJ9duC6sW8+e7sQHuxcONHn1Bm2
         pA1wS928va/XyNAnqV8jxGFj33duinqRHd+tnhZojxeriad5MIUXDtAhqhCqlao5K4Ni
         M3To3kpv9PkqlPQyy4I2tOR94IL0aZt7YULOfgS8gm+i0KDT8MjxZj2H5+VIpdnYJFWn
         gO5H2E0sLnob/zyruQUTb8237C3Ag0szk4YSU5+y+7lTEB0KC59CwBkJYLRvFP98qVIZ
         qltVM70znWuEiY9ZokJuMnLs6VsoN5tQrKrM25yreSajOqKYaYnZbgzZsVbOQ1CbuHL/
         3Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xqza1RteE+yZnsf6TJJy8YfLugJSOmuDDR38PN1bfrc=;
        b=Eufdd9oFLq+PArlawYEyu+qxPCMbY+cQeYN+uLfIirAyHvqNGIuodyCKZGzOGphwLE
         /1mI3x/WllGY3NluWl3dMYdqT/5l5FLKsfb0KlfKVAOrFQ+dZUpecqFHHY3wtoWBULvN
         VIgxc62tWj/DZCh4TbxrVpsd+gMFxYyD7eXS6iPO3AihXI97ZVRpZEhJ7TD9bzFuvQnI
         b4VdntKC8ltJrkD98bTcTLA7EhJmaAd8mqItcyTZAIf6izd/dTlPVMZr5bM9JN/pVuTg
         AyCRtmt7y1rnIWaO7mqVuPwQuXsf9DvpA/bZreTqqGt5FwyJ7D3fH//MIDAJGkIZ0Tez
         HkCA==
X-Gm-Message-State: APjAAAWgl6W715O0s9aC5PCP86mXGyO89rt7cNyyL6zU9BRentUEuH8O
        o+PVCsDmuZGh939n5hmJynnwaIuiiZ5n8qPCFQQ=
X-Google-Smtp-Source: APXvYqyBWIon8FQ32Ge0RTteBZ33psUWVbLEsMlRpTFDS2mZSgvHNpNjiHi3y69kR/hpO4Mc2qv9m2iBUKKaSHQIpfU=
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr528215plo.78.1561009607478;
 Wed, 19 Jun 2019 22:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
 <CAOQ4uxhC9x-quL0O9CYaqQ6_uX3yW_3PgW=a68AJboB4pjqz1w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhC9x-quL0O9CYaqQ6_uX3yW_3PgW=a68AJboB4pjqz1w@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 20 Jun 2019 00:46:35 -0500
Message-ID: <CAH2r5mtUK0AD=igA3fsmJC=ktWodWEhonytbaWHgvaNrt5H8dg@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:28 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 4:44 AM Steve French <smfrench@gmail.com> wrote:
> >
> > Patch attached fixes the case where copy_file_range over an SMB3 mount
> > tries to go beyond the end of file of the source file.  This fixes
> > xfstests generic/430 and generic/431
> >
> > Amir's patches had added a similar change in the VFS layer...
>
> BTW, Steve, do you intend to pull Darrick's copy-file-range-fixes
> branch for 5.3 and add the extra cifs "file_modified" patch?
>
> Thanks,
> Amir.

Yes - that seems reasonable to me


-- 
Thanks,

Steve
