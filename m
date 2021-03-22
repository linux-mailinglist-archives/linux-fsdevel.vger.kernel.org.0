Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78A33439F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 07:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCVGuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 02:50:44 -0400
Received: from verein.lst.de ([213.95.11.211]:53622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhCVGuQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:50:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE2BA67373; Mon, 22 Mar 2021 07:50:11 +0100 (CET)
Date:   Mon, 22 Mar 2021 07:50:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Message-ID: <20210322065011.GA2909@lst.de>
References: <20210322051344.1706-1-namjae.jeon@samsung.com> <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com> <20210322051344.1706-3-namjae.jeon@samsung.com> <20210322064712.GD1667@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322064712.GD1667@kadam>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:47:13AM +0300, Dan Carpenter wrote:
> On Mon, Mar 22, 2021 at 02:13:41PM +0900, Namjae Jeon wrote:
> > +static unsigned char
> > +asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
> > +{
> > +	if (ctx->pointer >= ctx->end) {
> > +		ctx->error = ASN1_ERR_DEC_EMPTY;
> > +		return 0;
> > +	}
> > +	*ch = *(ctx->pointer)++;
> > +	return 1;
> > +}
> 
> 
> Make this bool.
>

More importantly don't add another ANS1 parser, but use the generic
one in lib/asn1_decoder.c instead.  CIFS should also really use it.
