Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B243D16BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhGUSUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238393AbhGUSUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626894047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gH3Ux0CT6hU+v/YeUAIBalSzkDA3DKDpAjmYag8B8E=;
        b=VWha/EgDRfOK8PiKeHoq/+hv9G9oq2wG+h67hbSeSx/pqF88eNqTiG/7Wpf0atguaSn9OK
        CiebzZTwa9wgHsAalzadcM6sIA7odfPRyZhRGWNm0CmCbLTQ0GrjScrQ43M85/sburDjbs
        pQNZzFA2Q4D+A+qPvz+58U3U8JKZbeg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-NVJ4b-YDN2iL7RaQrXWCjA-1; Wed, 21 Jul 2021 15:00:45 -0400
X-MC-Unique: NVJ4b-YDN2iL7RaQrXWCjA-1
Received: by mail-qk1-f197.google.com with SMTP id k12-20020a05620a414cb02903b9ade0af31so1754458qko.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 12:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1gH3Ux0CT6hU+v/YeUAIBalSzkDA3DKDpAjmYag8B8E=;
        b=KT65nAJjjAm4MrDU9bdCgj3L64wf4a8osqk5bJxeFg+y8iPV02DeK8o18OiUiVAzlx
         XH3kIzuo+1FF2xbr2uU7FVQ3jhsWrx9ZhNMOtBrYgjQL1dZVkfgkdo5gUznTHrwFSdQ/
         87Mm4czHzHy4ogF97+lH1Lz+UdoBic6i3wvzolGytYRK/bOoV3qCfeYl/14tOxPy0bNo
         QNNT5m7leIPKuEQLL3HefL2oZ5ZpCX+h/T8EPJcL9pVpUXYqnudJBPFdHTKLKPaDmTwe
         KHLQ6G13AO3pU4ooQSBxLhDfwqkcPvgznzJRvwK+Prf2q5mkQGa91jKAfDOaMO/dvUjV
         Nd8w==
X-Gm-Message-State: AOAM533YKX1oMVs6x5EuhY+O1CvtTbqiw83BbPw+DsazBiaFArBaJfrh
        QLdGo8U4X/Lp/Qv0Vbwc/7kAO0zbs2/4Z6eXN1jSrnDuJ32enXJbRM/m76fpV+vKjwuX/VlNKEr
        mOaMEKbFje8VCfCuJARFc4SXx5Q==
X-Received: by 2002:a0c:e70f:: with SMTP id d15mr4739148qvn.47.1626894045392;
        Wed, 21 Jul 2021 12:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLJs8XXnPDqD0EYRCTwpJGY8jpuBbe7MH5DxMPfLcBBLk08k/UTRTJHL2M7llSs52l9VDF/g==
X-Received: by 2002:a0c:e70f:: with SMTP id d15mr4739113qvn.47.1626894045207;
        Wed, 21 Jul 2021 12:00:45 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id x7sm9290487qtw.24.2021.07.21.12.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:00:44 -0700 (PDT)
Message-ID: <56b3c140a388b98f74f2e71c656e77655da3129f.camel@redhat.com>
Subject: Re: [RFC PATCH 03/12] netfs: Remove
 netfs_read_subrequest::transferred
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 15:00:43 -0400
In-Reply-To: <298117.1626893692@warthog.procyon.org.uk>
References: <e7a3b850e8a42845f4e020c7642743b3dce2b9f1.camel@redhat.com>
         <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
         <162687511125.276387.15493860267582539643.stgit@warthog.procyon.org.uk>
         <298117.1626893692@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-21 at 19:54 +0100, David Howells wrote:
> Jeff Layton <jlayton@redhat.com> wrote:
> 
> > The above two deltas seem like they should have been in patch #2.
> 
> Yeah.  Looks like at least partially so.
> 
> > > @@ -635,15 +625,8 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
> > >  		goto failed;
> > >  	}
> > >  
> > > -	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
> > > -		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
> > > -		 rreq->debug_id, subreq->debug_index,
> > > -		 transferred_or_error, subreq->len, subreq->transferred))
> > > -		transferred_or_error = subreq->len - subreq->transferred;
> > > -
> > >  	subreq->error = 0;
> > > -	subreq->transferred += transferred_or_error;
> > > -	if (subreq->transferred < subreq->len)
> > > +	if (iov_iter_count(&subreq->iter))
> > >  		goto incomplete;
> > >  
> > 
> > I must be missing it, but where does subreq->iter get advanced to the
> > end of the current read? If you're getting rid of subreq->transferred
> > then I think that has to happen above, no?
> 
> For afs, afs_req_issue_op() points fsreq->iter at the subrequest iterator and
> calls afs_fetch_data().  Thereafter, we wend our way to
> afs_deliver_fs_fetch_data() or yfs_deliver_fs_fetch_data() which set
> call->iter to point to that iterator and then call afs_extract_data() which
> passes it to rxrpc_kernel_recv_data(), which eventually passes it to
> skb_copy_datagram_iter(), which advances the iterator.
> 
> For the cache, the subrequest iterator is passed to the cache backend by
> netfs_read_from_cache().  This would be cachefiles_read() which calls
> vfs_iocb_iter_read() which I thought advances the iterator (leastways,
> filemap_read() keeps going until iov_iter_count() reaches 0 or some other stop
> condition occurs and doesn't thereafter call iov_iter_revert()).
> 

Ok, this will probably regress ceph then. We don't really have anything
to do with the subreq->iter at this point and this patch doesn't change
that. If you're going to make this change, it'd be cleaner to also fix
up ceph_netfs_issue_op to advance the iter at the same time.
-- 
Jeff Layton <jlayton@redhat.com>

