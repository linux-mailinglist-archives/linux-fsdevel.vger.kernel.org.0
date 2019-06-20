Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90EA4C5BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 05:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFTDTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 23:19:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44038 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfFTDTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:19:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so762522pgp.11;
        Wed, 19 Jun 2019 20:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp34zPIUrb71nTEsb/w2CaqKtLsW0ovydoMfUVQfX2g=;
        b=IoBozTWI6WtiCJTjV5NVr5SK0AA+MX+bIezWwVENPB0FtS2bmHKNJgOcVwI1rGC2NG
         o7W5ibrgd/z/Id8BgHBLmMTCedwScz4+Wir2UsunN9Y2LMH86ssriAp2TJ7p6Adjd6Yy
         lrIbD3oPOA0f4HTfhowdSMHII3y2arp4w44aXs1cOND1cQFZPIV417K8U+aRDAoTV9fj
         J2zn6+8EIoQFCi2A8k1eoBhS1Vr7NFvx2DlmlWlBHg6Wd5nObXQaqaft151jJ8qdSBjo
         OH8xQWYk7UOdRnYdQpCUBhrkW9QpmFc5DZIKOtlyFkC+KVEV+NSoZDdgEukFIJ1mqQfv
         hlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp34zPIUrb71nTEsb/w2CaqKtLsW0ovydoMfUVQfX2g=;
        b=Uo0q1/eM7q3pi78jKLE9WVisLN4IU3eL+NapKPUPolf0d3XPPxUWvYgSx6cB9wYKHS
         f3PvFFz1sgMXlLluuMaSchJJ9q6W/QVm86KvR6WEEsqvmZiSoVf8b1y6I0fA1tkHm/g4
         0Zbtk9KxIOGg3S7Us6THN468rL7c/mHV1NZAxMctjUkceDEVJt7oVxXS6ZFgVkyrORZv
         N0Rav3rBewgQoNWGi8AH7DL4xlpQeER5nMkTJYcNZA2IORkVHPJbhiU1TKk2/daAg8mL
         w38C2AS6IrOIIdPhPfet65g0AKJbWty46pbmtEV4DPACYPcEfCUce7RRjqOLFvLFCNcD
         nEuQ==
X-Gm-Message-State: APjAAAWaD77/ab3bh0SiJ2ylN5JzOy5oLHkMSZzzO4QF2U34yKlO4/Am
        PERGXQDH/z/0dxLrmfcjpPtkztZoEFr/gHul/EfHYQ==
X-Google-Smtp-Source: APXvYqzEK2SNsIPuAc7sDwFOPRdq0DtDw6mtbAEdjPlm8oUqc+2nDmjR1fPIQakln4aYopalNBSAEzkB7czYW5LSYZc=
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr653250pjb.138.1561000781617;
 Wed, 19 Jun 2019 20:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
 <CAN05THSoKCKCFXkzfSiKC0XUb3R1S3B9nc2b9B+8ksKDn+NE_A@mail.gmail.com>
In-Reply-To: <CAN05THSoKCKCFXkzfSiKC0XUb3R1S3B9nc2b9B+8ksKDn+NE_A@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 19 Jun 2019 22:19:30 -0500
Message-ID: <CAH2r5mu0kZFhOyg3sXw6NVaAjyVGKuNdRGP=r_MoKqtJSqXJbw@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Local file systems that I tried, seem to agree with xfstest and return
0 if you try to copy beyond end of src file but do create a zero
length target file

On Wed, Jun 19, 2019 at 9:14 PM ronnie sahlberg
<ronniesahlberg@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 11:45 AM Steve French via samba-technical
> <samba-technical@lists.samba.org> wrote:
> >
> > Patch attached fixes the case where copy_file_range over an SMB3 mount
> > tries to go beyond the end of file of the source file.  This fixes
> > xfstests generic/430 and generic/431
> >
> > Amir's patches had added a similar change in the VFS layer, but
> > presumably harmless to have the check in cifs.ko as well to ensure
> > that we don't try to copy beyond end of the source file (otherwise
> > SMB3 servers will return an error on copychunk rather than doing the
> > partial copy (up to end of the source file) that copy_file_range
> > expects).
>
> + if (src_off >= inode->i_size) {
> + cifs_dbg(FYI, "nothing to do on copychunk\n");
> + goto cchunk_out; /* nothing to do */
> + } else if (src_off + len > inode->i_size) {
> + /* consider adding check to see if src oplocked */
> + len = inode->i_size - src_off;
> + cifs_dbg(FYI, "adjust copychunk len %lld less\n", len);
> + }
>
> This makes us return rc == 0 when this triggers. Is that what we want?
> Looking at "man copy_file_range" suggests we should return -EINVAL in
> both these cases.
>
>
>
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve



-- 
Thanks,

Steve
