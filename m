Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484FFE2808
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408172AbfJXCUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:20:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406401AbfJXCUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yy+Q+MO7o3PqEp+UoYBC+R7KWKu64kj6MbDxzFRIVS4=; b=dEnCgxsTOr8tUJZcVSZ/rftmR
        HG6hrUcy3fuLKRMfJFmQGZBe9RKe2ulMzp4klpRgLlbx5ccaLeLmBDZtC3z+hsdqUdHBPh6qmoj6t
        aWTIivoXL4Mm5lDxc3wf/EbvTsfvBlQdhhc6rWjGpUDl67985LsRKo+4vo4NqqkfadocUqxDHuffT
        mSvLfD3/POsYxbdNLWzOw90RLub2ve2ebuNsCFgZEj6S0/Z4fM4JFtFbbj0LmU7zA9bpm/60/rZGK
        W3sNARSq/vUTTGaZOhgVcr24OnFRFzOMZ/bkN60Wg3hdNWnEHjII2Qg1T+l5QIRxXxIuS4eaOlCLa
        1qduQRcxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSjG-00038m-B6; Thu, 24 Oct 2019 02:19:58 +0000
Date:   Wed, 23 Oct 2019 19:19:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] cdrom: factor out common open_for_* code
Message-ID: <20191024021958.GA11485@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  static
> -int open_for_data(struct cdrom_device_info *cdi)
> +int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)

Please fix the coding style.  static never should be on a line of its
own..

>  			} else {
>  				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
> -				ret=-ENOMEDIUM;
> -				goto clean_up_and_return;
> +				return -ENOMEDIUM;

Can you revert the polarity of the if opening the block before and
return early for the -ENOMEDIUM case to save on leven of indentation?

>  			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {

If you touch the whole area please remove the inner braces and add the
proper spaces around the second ==.

> +static
> +int open_for_data(struct cdrom_device_info *cdi)

Same issue with the static here.
