Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEF134A09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgAHSDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:03:06 -0500
Received: from verein.lst.de ([213.95.11.211]:50572 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHSDG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:03:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FC9F68BFE; Wed,  8 Jan 2020 19:03:04 +0100 (CET)
Date:   Wed, 8 Jan 2020 19:03:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
Message-ID: <20200108180304.GE14650@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com> <20200102082036.29643-10-namjae.jeon@samsung.com> <20200102091902.tk374bxohvj33prz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102091902.tk374bxohvj33prz@pali>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd, can you review the exfat time handling, especially vs y2038
related issues?

On Thu, Jan 02, 2020 at 10:19:02AM +0100, Pali Rohár wrote:
> On Thursday 02 January 2020 16:20:32 Namjae Jeon wrote:
> > This adds the implementation of misc operations for exfat.
> > 
> > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > ---
> >  fs/exfat/misc.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 253 insertions(+)
> >  create mode 100644 fs/exfat/misc.c
> > 
> > diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> > new file mode 100644
> > index 000000000000..7f533bcb3b3f
> > --- /dev/null
> > +++ b/fs/exfat/misc.c
> 
> ...
> 
> > +/* <linux/time.h> externs sys_tz
> > + * extern struct timezone sys_tz;
> > + */
> > +#define UNIX_SECS_1980    315532800L
> > +
> > +#if BITS_PER_LONG == 64
> > +#define UNIX_SECS_2108    4354819200L
> > +#endif
> 
> ...
> 
> > +#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x7F)
> > +/* Convert linear UNIX date to a FAT time/date pair. */
> > +void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
> > +		struct exfat_date_time *tp)
> > +{
> > +	time_t second = ts->tv_sec;
> > +	time_t day, month, year;
> > +	time_t ld; /* leap day */
> 
> Question for other maintainers: Has kernel code already time_t defined
> as 64bit? Or it is still just 32bit and 32bit systems and some time64_t
> needs to be used? I remember that there was discussion about these
> problems, but do not know if it was changed/fixed or not... Just a
> pointer for possible Y2038 problem. As "ts" is of type timespec64, but
> "second" of type time_t.
> 
> > +
> > +	/* Treats as local time with proper time */
> > +	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
> > +	tp->timezone.valid = 1;
> > +	tp->timezone.off = TIMEZONE_CUR_OFFSET();
> > +
> > +	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
> > +	if (second < UNIX_SECS_1980) {
> > +		tp->second  = 0;
> > +		tp->minute  = 0;
> > +		tp->hour = 0;
> > +		tp->day  = 1;
> > +		tp->month  = 1;
> > +		tp->year = 0;
> > +		return;
> > +	}
> > +
> > +	if (second >= UNIX_SECS_2108) {
> 
> Hello, this code cause compile errors on 32bit systems as UNIX_SECS_2108
> macro is not defined when BITS_PER_LONG == 32.
> 
> Value 4354819200 really cannot fit into 32bit signed integer, so you
> should use 64bit signed integer. I would suggest to define this macro
> value via LL not just L suffix (and it would work on both 32 and 64bit)
> 
>   #define UNIX_SECS_2108    4354819200LL
> 
> > +		tp->second  = 59;
> > +		tp->minute  = 59;
> > +		tp->hour = 23;
> > +		tp->day  = 31;
> > +		tp->month  = 12;
> > +		tp->year = 127;
> > +		return;
> > +	}
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
---end quoted text---
