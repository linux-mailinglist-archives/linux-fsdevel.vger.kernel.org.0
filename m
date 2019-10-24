Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F968E33A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502412AbfJXNM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 09:12:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393478AbfJXNM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ytz4euQ3Q9IiQz4tzDOyqx9l5irsf3dHQZgptwpBWK4=; b=IQ8lRqhl5fUKjdfhzlK2LtcFbT
        ADtwLGl+3iKxddWBK8Tla9MBG84wPpzPvgJOMdMkgp7fyM1UvasRb742v4912vRIUM0v4ntKXfvrr
        0FXECfgafbisrvDHiF+eb/hyEdWJCGyvhRFV+YGD5U/tSTegRmptZ9bHLpG1ohFMPrYj/AkKduclU
        gG6uyXAOCEsXDRjo2wTpFO0EHREP0idSNbpJofcTFCuZtVx5LXYEGsPIs0uUjN7/7tF4jBW71Dp1L
        OZZf5qqSL2/j0rdyCSCz/32qXI7cnab27HRgxXsLK0Ry73JygnlTWgfguNcMYXUgk12NuQmKgfPre
        BaVZk9Zw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNcv8-0004bG-FR; Thu, 24 Oct 2019 13:12:54 +0000
Date:   Thu, 24 Oct 2019 06:12:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v2 6/8] bdev: add open_finish.
Message-ID: <20191024131254.GE2963@bombadil.infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <ea2652294651cbc8549736728c650d16d2fe1808.1571834862.git.msuchanek@suse.de>
 <20191024022232.GB11485@infradead.org>
 <20191024085514.GI938@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024085514.GI938@kitsune.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:55:14AM +0200, Michal Suchánek wrote:
> On Wed, Oct 23, 2019 at 07:22:32PM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 23, 2019 at 02:52:45PM +0200, Michal Suchanek wrote:
> > > Opening a block device may require a long operation such as waiting for
> > > the cdrom tray to close. Performing this operation with locks held locks
> > > out other attempts to open the device. These processes waiting to open
> > > the device are not killable.

You can use mutex_lock_killable() to fix that.

