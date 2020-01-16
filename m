Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529CA13D7D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAPKXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:23:10 -0500
Received: from verein.lst.de ([213.95.11.211]:55239 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAPKXK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:23:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 860F468B20; Thu, 16 Jan 2020 11:23:07 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:23:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200116102307.GA16662@lst.de>
References: <20200115082447.19520-10-namjae.jeon@samsung.com> <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com> <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com> <20200115133838.q33p5riihsinp6c4@pali> <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com> <20200115142428.ugsp3binf2vuiarq@pali> <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com> <20200115153943.qw35ya37ws6ftlnt@pali> <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com> <20200116101947.4szdyfwpyasv5vpe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116101947.4szdyfwpyasv5vpe@pali>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:19:47AM +0100, Pali Rohár wrote:
>   However, implementations should only record the value 00h for this
>   field when:
> 
>     1. Local date and time are actually the same as UTC, in which case
>        the value of the OffsetValid field shall be 1
> 
>     2. Local date and time are not known, in which case the value of the
>        OffsetValid field shall be 1 and implementations shall consider
>        UTC to be local date and time

Given time zones in Linux are per session I think our situation is
somewhat similar to 2.

> > Here I would just convert to UTC, which is what we store in the
> > in-memory struct inode anyway.
> 
> Ok. If inode timestamp is always in UTC, we should do same thing also
> for exFAT.

> Hm... both UTC and sys_tz have positives and negatives. And I'm not
> sure which option is better.

The one big argument for always UTC is simplicity.  Always using UTC
kills some arcane an unusual (for Linux file systems) code, and given
how exfat implementations deal with the time zone on reading should
always interoperate fine with other implementations.
