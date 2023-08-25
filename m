Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28077788B80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbjHYOTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjHYOTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F62D51
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692973018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW2pKWmiWuGVCpTSPaJ/2vNwmbskt87fODz1wXV/nco=;
        b=ObuJyvXXIaZwVl3pYuA5tQqp+8vTEMFKCjeSTUM2jCvgYaPxFdnvY6zJrH0od2s7j093eY
        pp+PtwaJybLcJ9UTZuFYtk0e0GnDZC0xhjjIPy0+NcgmnC9N+iif9XsbMZpjIVUNW/ns/i
        TAyL6SqQmvU45/7CFZADwSvNzW8ISfg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-KEHN0PbYNgiWPKyARgUwGw-1; Fri, 25 Aug 2023 10:16:56 -0400
X-MC-Unique: KEHN0PbYNgiWPKyARgUwGw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c0d58f127fso9169595ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 07:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973016; x=1693577816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW2pKWmiWuGVCpTSPaJ/2vNwmbskt87fODz1wXV/nco=;
        b=D78nUJBFQD50oK9eyebmH+jtcnXpqj5K/ms+Qao/95e6ggpBfUzZ/c9Wo1kMbQs6W8
         MiqMA24BTIparDFI7HEj4fa9LGRsmEcfnyqxPHQRmGC7Vu8Z2+ovgyxAgy1EHLETVdwh
         cPLyUuju7xmDwljJe+9a0UfCGlcrNhr8+5Ub5gJgmI3GgvDUYrYNRG1jya+NHuB4TPW7
         igDqU11LuEPdnQCdN8gnTsMWrBZjImJjtxTTXQ/5+vezBWV+oxRrw2kpEficOHAoAPZ3
         F4VTyB+DBUzn014IEWoERedtOxbO2ownK13KPXpMsX4uRn7loY/nrCaGsqdHeW3ZzQdW
         neCA==
X-Gm-Message-State: AOJu0Yxhfz4z0HNZIi/q1PFtooHBb5iEEBRuKgt58yu3tJ6oIbfrmWEq
        QefVrNJpZHpCOOrVURT1zafmSCJ+/WDgsMikQCwsn5+2WS2tZgc9im+t3YpmFW66XpKHlsfL4mn
        MwSG5/FJUdWRhLbQjbpkYiiQ9Ww==
X-Received: by 2002:a17:903:1cb:b0:1bc:2f17:c628 with SMTP id e11-20020a17090301cb00b001bc2f17c628mr23081279plh.56.1692973015961;
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNyJuRaeG/wD40ZlriJCiVyGeHnbnm97mEEygHS5vOfubfDn6+ZG24ejI/qSeWLcZMOy99Mw==
X-Received: by 2002:a17:903:1cb:b0:1bc:2f17:c628 with SMTP id e11-20020a17090301cb00b001bc2f17c628mr23081258plh.56.1692973015671;
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001bd41b70b60sm1759088plf.45.2023.08.25.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:16:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems that
 support FIEMAP
Message-ID: <20230825141651.vd6lh3n4ztru5svl@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
 <20230824170931.GC11251@frogsfrogsfrogs>
 <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:28:26PM -0400, Jeff Layton wrote:
> On Thu, 2023-08-24 at 10:09 -0700, Darrick J. Wong wrote:
> > On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> > > Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
> > > filesystems that do.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  common/rc         | 13 +++++++++++++
> > >  tests/generic/578 |  1 +
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 33e74d20c28b..98d27890f6f7 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
> > >  	fi
> > >  }
> > >  
> > > +_require_fiemap()
> > > +{
> > > +	local testfile=$TEST_DIR/fiemaptest.$$
> > > +
> > > +	touch $testfile
> > > +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> > > +	if grep -q 'Operation not supported' $testfile.out; then
> > > +	  _notrun "FIEMAP is not supported by this filesystem"
> > > +	fi
> > > +
> > > +	rm -f $testfile $testfile.out
> > > +}
> > 
> > _require_xfs_io_command "fiemap" ?
> > 
> > 
> 
> Ok, I figured we'd probably do this test after testing for that
> separately, but you're correct that we do require it here.
> 
> If we add that, should we also do this, at least in all of the general
> tests?
> 
>     s/_require_xfs_io_command "fiemap"/_require_fiemap/
> 
> I think we end up excluding some of those tests on NFS for other
> reasons, but other filesystems that don't support fiemap might still try
> to run these tests.

We have lots of cases contains _require_xfs_io_command "fiemap", so I think
we can keep this "tradition", don't bring a new _require_fiemap for now,
so ...

>  
> > > +
> > >  _count_extents()
> > >  {
> > >  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
> > > diff --git a/tests/generic/578 b/tests/generic/578
> > > index b024f6ff90b4..903055b2ca58 100755
> > > --- a/tests/generic/578
> > > +++ b/tests/generic/578
> > > @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
> > >  _require_command "$FILEFRAG_PROG" filefrag
> > >  _require_test_reflink
> > >  _require_cp_reflink
> > > +_require_fiemap

_require_xfs_io_command "fiemap"

> > >  
> > >  compare() {
> > >  	for i in $(seq 1 8); do
> > > 
> > > -- 
> > > 2.41.0
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

