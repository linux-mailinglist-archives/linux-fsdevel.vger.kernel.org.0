Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA36F5EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjECS4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjECSzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68219A8
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683140110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wQvdyQB5pPdHshJ2DLccYdmYWvyKpPO5JRJ2uuF8Xo=;
        b=YZuCEMvlEoQVscpoykchxRHhECkchtP+r2giBuFtY5IbEPWk7uVKezn3YpPvKYSnakIX2a
        TV/1hpI9E5qmhrotUfYpSIJm3DjuIoQvgBsOsVPwVhfE2AksU5fNotnovHHF1xUwVAgOff
        ufhXcw1I2ZLFu+RV470qR+cxSLbXrac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-8tND3QyKMRCvOu967A9VsQ-1; Wed, 03 May 2023 14:55:06 -0400
X-MC-Unique: 8tND3QyKMRCvOu967A9VsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 179CA800B35;
        Wed,  3 May 2023 18:55:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9ECC15BAE;
        Wed,  3 May 2023 18:55:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230503154526.1223095-2-hch@lst.de>
References: <20230503154526.1223095-2-hch@lst.de> <20230503154526.1223095-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/2] afs: fix the afs_dir_get_folio return value
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1916966.1683140103.1@warthog.procyon.org.uk>
Date:   Wed, 03 May 2023 19:55:03 +0100
Message-ID: <1916967.1683140103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> Keep returning NULL on failure instead of letting an ERR_PTR escape to
> callers that don't expect it.
> 
> Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>

