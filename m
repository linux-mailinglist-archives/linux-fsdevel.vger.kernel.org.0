Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D726B1151
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 19:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCHSsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 13:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCHSsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:48:52 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85BBA854
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 10:48:49 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g18so17613933ljl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678301328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv1akr0dZXtnui0AYhF/JTPAEZAhJzReOkFX7K2EQXI=;
        b=bI0aX4HcMMrcRBC/bfaC9yUDlvK7mWA/9x10juYKdxQHmvafOcldF6qHv38hhBvrxd
         4GO1Hff5ZHy4/lJFvPvRCUcXShF77kux8dYMbazkGTpy5Kx0D5Vt3gcnfac1KLfHXqFA
         jy+qPpGPPF6IPX5/gagGXrvDGWe8zrQNVTM7f3mfVd6vZGOStmsYUtE3mh7gjCz0eI9Q
         WjS/swu5Z82D81cE2R0uxuh3yjKjiok448C8Juam+UXcCKfjAzTKs+EJFuTw0O0rjp4Q
         8tM+FBYTKdBd5X5LHLF86AuQiZVqoLdrYWdtxlHXFtn7xlKesWRHkF/yxHciGxMNATh2
         Cc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv1akr0dZXtnui0AYhF/JTPAEZAhJzReOkFX7K2EQXI=;
        b=2QLQbbos9IE4lou5v+FKjii7gRcuXOCgzamrPg6MJ6xiJR76YN0zYwdhytYSW/MWxx
         ILZuhIl9aqLWD9fZDHMd2gV0R2S4uwjYM6WKemUirheQqENcuO4PCpROsKNMjmg+qkxT
         MCLu+is+dsWAXBV1+gGghQiDDNFUzkrcKrOiL7958JTrVQLAVD1LduY4MQ0065XcaarR
         ROE/J/gUDkThsOkZl23zvcxnc5wIaL9WmL+D3nutbYzPPN0cB3uL2D5WT6WSi07H6z9n
         0PQcTT55CvwSq5e5Av0ZtLLonziTF38p64QjfwlSTaOMqX0kGM3s2OEtI7A23RsL2TSz
         c1oQ==
X-Gm-Message-State: AO0yUKUOqvzJw5TEABR/+hHUrujWc3cc96blK8VhrkZYWWt5uiu+yNVW
        WgSpDXbmwkWWzl5hQKG0wuWaAAcSpgjgeeSD9t6Fyw==
X-Google-Smtp-Source: AK7set8PLn02wnWoSUWxQIWomi2iCtDNFADbqKGcA05FOKTzYMA7/Qhpj7WLdjLjE3q+UKaTpvUPM2Jznr4RY5wfm84=
X-Received: by 2002:a2e:b8d2:0:b0:295:b0cd:522 with SMTP id
 s18-20020a2eb8d2000000b00295b0cd0522mr6167764ljp.2.1678301327684; Wed, 08 Mar
 2023 10:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20230306225024.264858-5-axelrasmussen@google.com> <202303081703.nwxAgIVH-lkp@intel.com>
In-Reply-To: <202303081703.nwxAgIVH-lkp@intel.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 8 Mar 2023 10:48:11 -0800
Message-ID: <CAJHvVciSP9QyF33GFveESFW3o7vyxbydq2vR4t7tnunJLJNjWg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len arguments
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 8, 2023 at 1:52=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Axel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.3-rc1]
> [cannot apply to akpm-mm/mm-everything next-20230308]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Axel-Rasmussen/mm-=
userfaultfd-rename-functions-for-clarity-consistency/20230307-065203
> patch link:    https://lore.kernel.org/r/20230306225024.264858-5-axelrasm=
ussen%40google.com
> patch subject: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len =
arguments
> config: x86_64-randconfig-a011-20230306 (https://download.01.org/0day-ci/=
archive/20230308/202303081703.nwxAgIVH-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c=
006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/cee642b93be3ae01c=
7cc737c0176cbc16074a25a
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Axel-Rasmussen/mm-userfaultfd-re=
name-functions-for-clarity-consistency/20230307-065203
>         git checkout cee642b93be3ae01c7cc737c0176cbc16074a25a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303081703.nwxAgIVH-lkp@i=
ntel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/userfaultfd.c:577:52: error: passing 'const struct uffdio_range *' =
to parameter of incompatible type 'struct uffdio_range'
>                    return  mfill_atomic_hugetlb(dst_vma, src_start, dst, =
flags);
>                                                                     ^~~
>    mm/userfaultfd.c:463:29: note: passing argument to parameter 'dst' her=
e
>                                        struct uffdio_range dst,
>                                                            ^
>    1 error generated.

Whoops. :) I admittedly didn't test with !CONFIG_HUGETLB_PAGE.

The next version of this series will drop this patch as per discussion
though, so the issue is moot.

>
>
> vim +577 mm/userfaultfd.c
>
>    508
>    509  static __always_inline ssize_t mfill_atomic(struct mm_struct *dst=
_mm,
>    510                                              unsigned long src_sta=
rt,
>    511                                              const struct uffdio_r=
ange *dst,
>    512                                              atomic_t *mmap_changi=
ng,
>    513                                              uffd_flags_t flags)
>    514  {
>    515          struct vm_area_struct *dst_vma;
>    516          ssize_t err;
>    517          pmd_t *dst_pmd;
>    518          unsigned long src_addr, dst_addr;
>    519          long copied;
>    520          struct page *page;
>    521
>    522          /*
>    523           * Sanitize the command parameters:
>    524           */
>    525          BUG_ON(dst->start & ~PAGE_MASK);
>    526          BUG_ON(dst->len & ~PAGE_MASK);
>    527
>    528          /* Does the address range wrap, or is the span zero-sized=
? */
>    529          BUG_ON(src_start + dst->len <=3D src_start);
>    530          BUG_ON(dst->start + dst->len <=3D dst->start);
>    531
>    532          src_addr =3D src_start;
>    533          dst_addr =3D dst->start;
>    534          copied =3D 0;
>    535          page =3D NULL;
>    536  retry:
>    537          mmap_read_lock(dst_mm);
>    538
>    539          /*
>    540           * If memory mappings are changing because of non-coopera=
tive
>    541           * operation (e.g. mremap) running in parallel, bail out =
and
>    542           * request the user to retry later
>    543           */
>    544          err =3D -EAGAIN;
>    545          if (mmap_changing && atomic_read(mmap_changing))
>    546                  goto out_unlock;
>    547
>    548          /*
>    549           * Make sure the vma is not shared, that the dst range is
>    550           * both valid and fully within a single existing vma.
>    551           */
>    552          err =3D -ENOENT;
>    553          dst_vma =3D find_dst_vma(dst_mm, dst);
>    554          if (!dst_vma)
>    555                  goto out_unlock;
>    556
>    557          err =3D -EINVAL;
>    558          /*
>    559           * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|=
MAP_SHARED but
>    560           * it will overwrite vm_ops, so vma_is_anonymous must ret=
urn false.
>    561           */
>    562          if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
>    563              dst_vma->vm_flags & VM_SHARED))
>    564                  goto out_unlock;
>    565
>    566          /*
>    567           * validate 'mode' now that we know the dst_vma: don't al=
low
>    568           * a wrprotect copy if the userfaultfd didn't register as=
 WP.
>    569           */
>    570          if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM=
_UFFD_WP))
>    571                  goto out_unlock;
>    572
>    573          /*
>    574           * If this is a HUGETLB vma, pass off to appropriate rout=
ine
>    575           */
>    576          if (is_vm_hugetlb_page(dst_vma))
>  > 577                  return  mfill_atomic_hugetlb(dst_vma, src_start, =
dst, flags);
>    578
>    579          if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>    580                  goto out_unlock;
>    581          if (!vma_is_shmem(dst_vma) &&
>    582              (flags & MFILL_ATOMIC_MODE_MASK) =3D=3D MFILL_ATOMIC_=
CONTINUE)
>    583                  goto out_unlock;
>    584
>    585          /*
>    586           * Ensure the dst_vma has a anon_vma or this page
>    587           * would get a NULL anon_vma when moved in the
>    588           * dst_vma.
>    589           */
>    590          err =3D -ENOMEM;
>    591          if (!(dst_vma->vm_flags & VM_SHARED) &&
>    592              unlikely(anon_vma_prepare(dst_vma)))
>    593                  goto out_unlock;
>    594
>    595          while (src_addr < src_start + dst->len) {
>    596                  pmd_t dst_pmdval;
>    597
>    598                  BUG_ON(dst_addr >=3D dst->start + dst->len);
>    599
>    600                  dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
>    601                  if (unlikely(!dst_pmd)) {
>    602                          err =3D -ENOMEM;
>    603                          break;
>    604                  }
>    605
>    606                  dst_pmdval =3D pmdp_get_lockless(dst_pmd);
>    607                  /*
>    608                   * If the dst_pmd is mapped as THP don't
>    609                   * override it and just be strict.
>    610                   */
>    611                  if (unlikely(pmd_trans_huge(dst_pmdval))) {
>    612                          err =3D -EEXIST;
>    613                          break;
>    614                  }
>    615                  if (unlikely(pmd_none(dst_pmdval)) &&
>    616                      unlikely(__pte_alloc(dst_mm, dst_pmd))) {
>    617                          err =3D -ENOMEM;
>    618                          break;
>    619                  }
>    620                  /* If an huge pmd materialized from under us fail=
 */
>    621                  if (unlikely(pmd_trans_huge(*dst_pmd))) {
>    622                          err =3D -EFAULT;
>    623                          break;
>    624                  }
>    625
>    626                  BUG_ON(pmd_none(*dst_pmd));
>    627                  BUG_ON(pmd_trans_huge(*dst_pmd));
>    628
>    629                  err =3D mfill_atomic_pte(dst_pmd, dst_vma, dst_ad=
dr,
>    630                                         src_addr, &page, flags);
>    631                  cond_resched();
>    632
>    633                  if (unlikely(err =3D=3D -ENOENT)) {
>    634                          void *page_kaddr;
>    635
>    636                          mmap_read_unlock(dst_mm);
>    637                          BUG_ON(!page);
>    638
>    639                          page_kaddr =3D kmap_local_page(page);
>    640                          err =3D copy_from_user(page_kaddr,
>    641                                               (const void __user *=
) src_addr,
>    642                                               PAGE_SIZE);
>    643                          kunmap_local(page_kaddr);
>    644                          if (unlikely(err)) {
>    645                                  err =3D -EFAULT;
>    646                                  goto out;
>    647                          }
>    648                          flush_dcache_page(page);
>    649                          goto retry;
>    650                  } else
>    651                          BUG_ON(page);
>    652
>    653                  if (!err) {
>    654                          dst_addr +=3D PAGE_SIZE;
>    655                          src_addr +=3D PAGE_SIZE;
>    656                          copied +=3D PAGE_SIZE;
>    657
>    658                          if (fatal_signal_pending(current))
>    659                                  err =3D -EINTR;
>    660                  }
>    661                  if (err)
>    662                          break;
>    663          }
>    664
>    665  out_unlock:
>    666          mmap_read_unlock(dst_mm);
>    667  out:
>    668          if (page)
>    669                  put_page(page);
>    670          BUG_ON(copied < 0);
>    671          BUG_ON(err > 0);
>    672          BUG_ON(!copied && !err);
>    673          return copied ? copied : err;
>    674  }
>    675
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
