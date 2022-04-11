Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919274FC467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349272AbiDKSx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349257AbiDKSx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:53:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9612616;
        Mon, 11 Apr 2022 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649703104; x=1681239104;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3NS2IckigsYPCW6uvTWzWoNogEPw6kTBCLQLlVDSA/w=;
  b=YFXU9kPUXNfX1I14Q3ebQ8+2Q+SxHCltlnTKIRqQFUQ2pjTfpCtqZQa3
   JslkjZl9IqTHI0a0c+flDNstM4PH1BgLgbJPVXBTyUYjhLVPiE87I5idB
   YoW0bH++cgXQoBizvKRZHYRnBAXY3NYH0oI1w/zMXoXYQGSZiDU/PtEHs
   qYZGJJ1qsyt8iTd7OiCTnqGpv9f6ez+TPxpy6uonMrv8asnKHeEuz4n/E
   eVFvBIMPSEIRw1iGIjrpyooizzQ/4Y4mFIhfHYs5Sa/Z9J17trebwm/Am
   70JsreTJQjb7X5okrZAKYMP+JZzdt8hA03z5Oq3G7zVZ49n1my/TOH9Da
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="249471959"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="249471959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:51:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572339167"
Received: from minhjohn-mobl.amr.corp.intel.com (HELO [10.212.44.201]) ([10.212.44.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:51:41 -0700
Message-ID: <dbd8a627-ce8d-8265-289d-30e0399a66e2@intel.com>
Date:   Mon, 11 Apr 2022 11:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <YlRnPstOywJzxUib@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
In-Reply-To: <YlRnPstOywJzxUib@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 10:37, Matthew Wilcox wrote:
> Another argument that MM developers find compelling is that we can reduce
> some of the complexity in hugetlbfs where it has the ability to share
> page tables between processes.

When could this complexity reduction actually happen in practice?  Can
this mshare thingy be somehow dropped in underneath the existing
hugetlbfs implementation?  Or would userspace need to change?
