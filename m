Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB52DE419C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfJYCic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:38:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=og4UwUe+IdpNdozHFTSH6d+IuI1h2CCsMk4c1RoYWD0=; b=hGKpSTAfckdqYjvK9u9zIy2nf
        6fFP+pD1oOAcPxZOa5hynTKk8ls+wO6dg/j82Xfi1hWoX69w/lNvfidaF0u5V/t7DLRO7pclcUkSb
        yBn1VwK/BWfRVmaQxEJxqYBu2jUWYnUc1izydmJZy0/VGUWeMRt/Qo/S5gcARgDqmNCXNrh7npuKm
        +/lkQkVZe3hUrg/cACPHYD3QAGoSEbiTz/cJ8ZGmJPYnVxqkr9T1uWkgJq32yFtvhCDdyUgU6DtTO
        h0zzfoN5mY2AUBxa+JcVsZlNwAuatQlhFiKXJ0Kniflwr0ZqTkV8yRrm6D8ZJtT8cc2/Qzi6JRy2E
        6U24WjTog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpUk-0003mZ-Kj; Fri, 25 Oct 2019 02:38:30 +0000
Date:   Thu, 24 Oct 2019 19:38:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20191025023830.GA14108@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
 <20191024021958.GA11485@infradead.org>
 <20191024132314.GG2963@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024132314.GG2963@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 06:23:14AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 23, 2019 at 07:19:58PM -0700, Christoph Hellwig wrote:
> > >  static
> > > -int open_for_data(struct cdrom_device_info *cdi)
> > > +int open_for_common(struct cdrom_device_info *cdi, tracktype *tracks)
> > 
> > Please fix the coding style.  static never should be on a line of its
> > own..
> 
> It's OK to have the static on a line by itself; it's having 'static int'
> on a line by itself that Linus gets unhappy about because he can't use
> grep to see the return type.

Sorry, but independent of any preference just looking at the codebases
proves you wrong.  All on one line is the most common style, but not
by much, followed by static + type.  Just static is just in a few crazy
