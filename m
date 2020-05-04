Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379341C4357
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgEDRyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:54:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728158AbgEDRyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588614877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o4SdY0w3UouF91y2gLQuR1sVRgD2BPdPwIappEYt/U=;
        b=RlXQPhgzh3gsilovZehVqYRsakFgZ6Pe7x9oLVqBETYyJ9pS8HJmW9EL29O741nN9aiza7
        6ttt4WCuyL+HVeGs2t8GJTudfQwNiAhVitQ1orQCw6+XfTd11I8p0yRWPljUDRAz4S0fCG
        n5AxVilHmDDaxRpnr6IwqrPQXZq9IGg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-zjBTcuYsPIWsFWs-XqnC8A-1; Mon, 04 May 2020 13:54:36 -0400
X-MC-Unique: zjBTcuYsPIWsFWs-XqnC8A-1
Received: by mail-qt1-f197.google.com with SMTP id v18so146448qtq.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 10:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+o4SdY0w3UouF91y2gLQuR1sVRgD2BPdPwIappEYt/U=;
        b=EgrLptp4Fm/jjrHjylqpwIllfLATMyA8R5y2VXVQu/GpWL6JhPWFTw7h/+B4MzcuLa
         jN21Geey7aew1U4ilhUKDPUjXa7YXrsDwWoMQJoo3mtym9HcMe+QIgZN8M7Vyhfy8NKe
         8BdZDOrCkTD3k0es4U6x494uO2zzghJaHcpOBDEuPHN6bqMMEr+RZ72ES8oXjb7IZzXt
         CKonDLb0/7yvw14IWiX0CdBm2Ltd3JidUrKIvRjghLE7aiLT91NqbGgnWfl+7UAJiV0I
         E8T3TH2uDK8G3y8Q1guuBvkqwFoQpDhk4WUSh2CgD9oDOuswANuJrLXM+/AUFbTE1epe
         ugVw==
X-Gm-Message-State: AGi0PubNo89JX8M+iKG7o1fvqS0OGkIBlz2AaAIRD1ZQ6WmhDAcbfXZi
        CiVwZJVbdC2nVFIpML2uKhkp/GnmbtH0CUWdgCtE9oHcm0+L4oz4TzuE+wWf6UbcJXmrcedsHTq
        wQOsgxH7FUXqRHjp+NlLyVeJZRA==
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr370216qkb.131.1588614875627;
        Mon, 04 May 2020 10:54:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypK3uCi6lFkdGRP90/JqMNVl2EPo4jU4+vUXICbUKWh5Z7zHzwK3PWjYZaZSl3+osjCddPgO1g==
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr370193qkb.131.1588614875436;
        Mon, 04 May 2020 10:54:35 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id q32sm12123066qta.13.2020.05.04.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:54:34 -0700 (PDT)
Message-ID: <63498a6eedc7994b1e96a59d12468bfd15e15ef4.camel@redhat.com>
Subject: Re: [RFC PATCH 00/61] fscache, cachefiles: Rewrite the I/O
 interface in terms of kiocb/iov_iter
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 13:54:33 -0400
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-05-04 at 18:07 +0100, David Howells wrote:
> 
>  (3) Make NFS, CIFS, Ceph, 9P work with it.  I'm hoping that Jeff Layton will
>      do Ceph.  As mentioned, I'm having a crack at NFS, but it's evolved a bit
>      since I last looked at it and it might be easier if I can palm that off
>      to someone more current in the NFS I/O code.
> 
> 

[...]

This looks like a really nice overhaul. I particularly love the
diffstat. Net removal of ~4000 lines!

I'll plan to draft up a patch for Ceph in the near future. The new API
seems to be quite different, so I imagine this will more or less be a
rip and replace on the old code.
-- 
Jeff Layton <jlayton@redhat.com>

