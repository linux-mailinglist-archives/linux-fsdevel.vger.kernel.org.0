Return-Path: <linux-fsdevel+bounces-4-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EA7C43B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC18281E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269332C84;
	Tue, 10 Oct 2023 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyglCR9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAB32C7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A148F;
	Tue, 10 Oct 2023 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9AGiLTlqtyIGaBzD7IOjNpQgtkRKRaKi8pUmOot2w4M=; b=tyglCR9LBh6Vl3Fph2HnHlHQtO
	acIvmZrvWyjcuuE6PE8hvNLiuQT1GSN++6loqxNUa/o5kIe8nFkWTpBVvMOq2Ice63MgrMEtsq6S2
	6KlEKbIJ9q/QxWOredRN8uJL63aL0nDdwWK/DwqQ4Yz0veLS/2jlIoU4k7H98/Nt1f/4/8sO6yAL+
	PsMAkrf40vjdvyCGjv5QD/uKrfrNzKsyAV4i6aLBNtwtjTKECoSS3lPIT1seEL/UOPP9cY6UjRDTf
	QZuMsYmPqnGLgN7YaMNW8aWr4wbw9yGiqe2il6HHywqVm1fmptxPJ4p2jowp8+fWw+2XPiIfvRybX
	bdKpFW+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqL7a-00EFUa-0R;
	Tue, 10 Oct 2023 22:22:34 +0000
Date: Tue, 10 Oct 2023 15:22:34 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: j.granados@samsung.com
Cc: willy@infradead.org, josh@joshtriplett.org,
	Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Guo Ren <guoren@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/7] sysctl: Remove sentinel elements from arch
Message-ID: <ZSXOqoCRH0PiBiIG@bombadil.infradead.org>
References: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 01:30:35PM +0200, Joel Granados via B4 Relay wrote:
> V3:
> * Removed the ia64 patch to avoid conflicts with the ia64 removal
> * Rebased onto v6.6-rc4
> * Kept/added the trailing comma for the ctl_table arrays. This was a comment
>   that we received "drivers/*" patch set.
> * Link to v2: https://lore.kernel.org/r/20230913-jag-sysctl_remove_empty_elem_arch-v2-0-d1bd13a29bae@samsung.com

Thanks! I replaced the v2 with this v3 on sysctl-next.

  Luis

