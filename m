Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED86E11A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDMQES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDMQER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:04:17 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903E7AB0;
        Thu, 13 Apr 2023 09:04:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D8DC95821BE;
        Thu, 13 Apr 2023 12:04:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Apr 2023 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681401852; x=
        1681409052; bh=yaqCPjOmT4SPOlCAxznT+4NGON1tEotsmgkNB1VGB30=; b=g
        StG2nxVku9iBD1WQagIAjbs9eRtIqZQ4YJ7OEYoZjd8lDxrtEdHK9TqLOIeSqwI/
        aRHxz87Qz45IxYCW54qgzCDISNjcqUTZEpEk1pt3VfmLnVVwuAPniOJ3FRodfKpI
        DEMHWreitIkO4k4mgbAot366VgZ2vWimK9fKuI1RKhuY+/rU3uUPOowpp+5JdmEA
        GgTYoBTSrgFdi7qpYlbquOANjGur+Ee0B0x1e9mN71cQweG+Ik8UL5j2jOOOdlxN
        wytXUgUVh1bYTkhj1s4j/Imizt257d5R/RoBcvHrgEciqzigMyAbV50wz4zIs+/h
        ZvAAYdSwUpPn20YgAC9eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681401852; x=1681409052; bh=yaqCPjOmT4SPO
        lCAxznT+4NGON1tEotsmgkNB1VGB30=; b=ZhPxOavXVNafxjBvoz0rHGSKV5lrB
        lBBeFJbThUiGvUr6dkUdUFPZBpFZ459KtreUM8/tmgj+GOIkARrz+/dxN2rCFKeh
        IpN6sEvHrSODWjpvtdkpXDz1uk3XIMGrQ83IpXODAFKPMkKNE1syCCeenvY3ochU
        sFkgoLNTQaB5KIJLTO17KkMdHMrJ9E9VdZJo8sSy642MoVNJ5ikM5yQQ28lztjFD
        TiMX1SDBBjQlQM4qnK05EPhjiIvKgDfGSNZek/aZtbj2uyFA98dRfxTSn3BEVOR9
        95NphpJRdnFA0NLiN2ijCyMAXgwwHtzwaDSgo3Z/2Vu+j3IZFBGr1TvRQ==
X-ME-Sender: <xms:-ic4ZN0HN98HMEwtW8V9mlbqa3gz5isroMmfB9qBPPUsWB8piPSjvA>
    <xme:-ic4ZEEDMamcIgksjdbPM69xhaMG7daCyWg7mg9Z0r1MEEvqt4e-SesCeEw7fqteb
    w_a7Jc6p1dt-60d7rk>
X-ME-Received: <xmr:-ic4ZN4gF2ji4V6weIhkOL3DDxAjJ1Xt75lynoODK2-gh23ltHDhlYoOj9gaEs0WxajnZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetvdehffelffeiveeikeduffetudeuheeiiefg
    ueduvdevtdejhedvhfffffehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:-ic4ZK3e6y7eAfhmn4e66gu0PUt85Z-wcC5DNlSWhilhhk6w4t8EXQ>
    <xmx:-ic4ZAECPW4s4BS3PWmFxf2t0_QIrnIg3FFBNPFHB4jha8PCamTX0A>
    <xmx:-ic4ZL9cmfcyroxf89k4ficZUhl3J7t6abTqqTh77eZahq7_J0-qYA>
    <xmx:_Cc4ZFJhth32jA7Up6aLA2dV58F_PmFV92-rLLWAX260cMRlG903Wg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 12:04:09 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B267B10D7C6; Thu, 13 Apr 2023 19:04:05 +0300 (+03)
Date:   Thu, 13 Apr 2023 19:04:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Liam Merwick <liam.merwick@oracle.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230413160405.h6ov2yl6l3i7mvsj@box.shutemov.name>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
 <Y9B1yiRR8DpANAEo@google.com>
 <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
 <ZDdV0Fh7nDEnY/eW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDdV0Fh7nDEnY/eW@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 06:07:28PM -0700, Sean Christopherson wrote:
> On Wed, Jan 25, 2023, Kirill A. Shutemov wrote:
> > On Wed, Jan 25, 2023 at 12:20:26AM +0000, Sean Christopherson wrote:
> > > On Tue, Jan 24, 2023, Liam Merwick wrote:
> > > > On 14/01/2023 00:37, Sean Christopherson wrote:
> > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > > This patch series implements KVM guest private memory for confidential
> > > > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > > > TDX-protected guest memory, machine check can happen which can further
> > > > > > crash the running host system, this is terrible for multi-tenant
> > > > > > configurations. The host accesses include those from KVM userspace like
> > > > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > > > via a fd-based approach, but it can never access the guest memory
> > > > > > content.
> > > > > > 
> > > > > > The patch series touches both core mm and KVM code. I appreciate
> > > > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > > > reviews are always welcome.
> > > > > >    - 01: mm change, target for mm tree
> > > > > >    - 02-09: KVM change, target for KVM tree
> > > > > 
> > > > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > > > is available here:
> > > > > 
> > > > >    git@github.com:sean-jc/linux.git x86/upm_base_support
> > > > > 
> > > > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > > > a WIP.
> > > > > 
> > > > 
> > > > When running LTP (https://github.com/linux-test-project/ltp) on the v10
> > > > bits (and also with Sean's branch above) I encounter the following NULL
> > > > pointer dereference with testcases/kernel/syscalls/madvise/madvise01
> > > > (100% reproducible).
> > > > 
> > > > It appears that in restrictedmem_error_page()
> > > > inode->i_mapping->private_data is NULL in the
> > > > list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) but I
> > > > don't know why.
> > > 
> > > Kirill, can you take a look?  Or pass the buck to someone who can? :-)
> > 
> > The patch below should help.
> > 
> > diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> > index 15c52301eeb9..39ada985c7c0 100644
> > --- a/mm/restrictedmem.c
> > +++ b/mm/restrictedmem.c
> > @@ -307,14 +307,29 @@ void restrictedmem_error_page(struct page *page, struct address_space *mapping)
> >  
> >  	spin_lock(&sb->s_inode_list_lock);
> >  	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> > -		struct restrictedmem *rm = inode->i_mapping->private_data;
> >  		struct restrictedmem_notifier *notifier;
> > -		struct file *memfd = rm->memfd;
> > +		struct restrictedmem *rm;
> >  		unsigned long index;
> > +		struct file *memfd;
> >  
> > -		if (memfd->f_mapping != mapping)
> > +		if (atomic_read(&inode->i_count))
> 
> Kirill, should this be
> 
> 		if (!atomic_read(&inode->i_count))
> 			continue;
> 
> i.e. skip unreferenced inodes, not skip referenced inodes?

Ouch. Yes.

But looking at other instances of s_inodes usage, I think we can drop the
check altogether. inode cannot be completely free until it is removed from
s_inodes list.

While there, replace list_for_each_entry_safe() with
list_for_each_entry() as we don't remove anything from the list.

diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index 55e99e6c09a1..8e8a4420d3d1 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -194,22 +194,19 @@ static int restricted_error_remove_page(struct address_space *mapping,
 					struct page *page)
 {
 	struct super_block *sb = restrictedmem_mnt->mnt_sb;
-	struct inode *inode, *next;
+	struct inode *inode;
 	pgoff_t start, end;
 
 	start = page->index;
 	end = start + thp_nr_pages(page);
 
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct restrictedmem_notifier *notifier;
 		struct restrictedmem *rm;
 		unsigned long index;
 		struct file *memfd;
 
-		if (atomic_read(&inode->i_count))
-			continue;
-
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
