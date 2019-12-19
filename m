Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141171261B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 13:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSMG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 07:06:56 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSMGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:06:55 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7hrw-1hdPlH2kDa-014iUw; Thu, 19 Dec 2019 13:06:53 +0100
Received: by mail-qt1-f175.google.com with SMTP id w47so4841476qtk.4;
        Thu, 19 Dec 2019 04:06:53 -0800 (PST)
X-Gm-Message-State: APjAAAXBpysAqOUpd6hdW7AkYF9anE8ixycq5E/EWty85GW+sE3rZNOY
        s/JBA+Uin0p/9kV6COCGCBcXnf6gBe/GEzuE3qs=
X-Google-Smtp-Source: APXvYqxGQKByw2kvN17TFz5IHkyanI0u18EN6ad0C5VbYexL/eZvygPOcm6Qo3HJ+QnsJhFv9L477EgsjzRCAopMqgw=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr6613343qtr.7.1576757212184;
 Thu, 19 Dec 2019 04:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de> <20191217221708.3730997-19-arnd@arndb.de>
 <f9fd39116713f17e55091868326a419190220559.camel@codethink.co.uk>
In-Reply-To: <f9fd39116713f17e55091868326a419190220559.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 13:06:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0oNYMoyLbpPqNaXSWV3j7dXhKZ5GLq1EEGA=ansVxvsA@mail.gmail.com>
Message-ID: <CAK8P3a0oNYMoyLbpPqNaXSWV3j7dXhKZ5GLq1EEGA=ansVxvsA@mail.gmail.com>
Subject: Re: [PATCH v2 18/27] compat_ioctl: scsi: move ioctl handling into drivers
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+fWi9PxG9cjEwLcZlRIq6OeQDH2hEZ4pw5hpJkGpVtEeWAlAivF
 CbPr0NC3QuKQvm6kKLoHJbAxJuZKqLJyDWcHTQoJ16eaRPEQvoCC1bXU6pKK9i/0/7yUFrB
 /TRpJyIWpD4oNYm1hCje7EqIkSxyFtmj5zAED48WVkQqJX39CCVvpG/jui6MqUa5Mk0gIYN
 Y1uy1exUFBIIvcQMWzNMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fuV12pAVl+Q=:JNkmuxB1GGiZ2oSKG3N9l2
 PecDtonxNza7r+VU1FQI2gXKy4eOwxT1z5eRg+T9pZaWPrLcxj72yCAuGMH1cPW0O7V/T8v39
 RhsZ4b5yA9jSeKcdlSw6k/srmunKQmq/f56xFwH/QxTN7aJFcdvmLcx4bcEAFzlJU7pPf2903
 aykxVDbdwsvWCfCTFojlHC7stwSemNAuIS+jfBxNDOrqZ1cmgPscmsCpIBMQtUZcyLbw2Ha65
 dSLuuHOtD49UvgeLeLCwjisAhAphYMVSM/gYJAnRg1Qui6fMkCbjV0UMdKK3nndXzxZKALi0t
 MlCjXoSbVqpLzEgwxeWcy/h7EmrR1pS93py40sGTq4RX77Cmap1qQkQK0cvADoH4lJjedY3C8
 jzHG1cw44oFuy3/M4PoMuxiFS8WZPa6T5nCMPdhY2V1NrswNFN3HYGggMfpIE80WrDiC7GAxz
 saPlqhJs6CzRCVELk1NIcGESwXBjGkFyoPBrrni/oVKUaQs8R55UIluhnywy6SdLw4+f0hdW8
 5O0u2sL/oyPoswBakGI9Ppr3A35o0XF3RMABoaJmvbaAHBvSblSt2KXUp64iAkDCkx35R9sp9
 +atIRp86CaJDxiaULDJ9NWYEL9LSwD3Eumw/LqNzm4bJvOn2e2YsP2SUZa4D5rKxX3JVcHSqT
 Kvlzg2O6KMb8B0r/Rqm4tZryip31E6BhzJyYos/0YHRhbioA6UbYwCbGHuVJfsCEpobZUz4QE
 ddlEKJzsI6UvRYWxHfSkMi3kD//JzyuunBqE+/vfsvHy8YNxDMb/CxHmwAnprNII66M82Yngg
 F5/ZjI7kY5rQCt2DR2G54kWOPp4LmWRDIt8v0U20UFpSMU2DolvDzNENy9atgl3rnn5wE/CJU
 5kC0Mp8mNra9q7mBhwew==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 8:57 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Tue, 2019-12-17 at 23:16 +0100, Arnd Bergmann wrote:
> > +
> > +     /*
> > +      * CDROM ioctls are handled in the block layer, but
> > +      * do the scsi blk ioctls here.
> > +      */
> > +     ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
> > +     if (ret != -ENOTTY)
> > +             return ret;
>
> This needs to be be "goto put;"

Fixed now, thanks!

       Arnd
